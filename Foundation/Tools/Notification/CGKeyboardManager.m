//
//  CGKeyboardManager.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGKeyboardManager.h"
#import "CGKeyboardCacheModel.h"

#import "NSNotification+CGKeyboardUserInfo.h"
#import "NSNotificationCenter+CGCreateNotification.h"

#import "UIView+CGSearchView.h"
#import "UIScrollView+CGSetupScrollProperty.h"

#import "UIView+Constant.h"

#import "CGPrintLogHeader.h"

@interface CGKeyboardManager ()
{
    //------------------------------------------
    //oldSendNotificationDate, timeIntervalValue 两变量使用条件 1.默认条件下，2.用约束来设置布局的情况下
    //上一个通知发送的时间
    NSDate *oldSendNotificationDate;
    //当前通知与上一个通知发送的时间间隔。用于判断当前的视图是否需要重新立即更新之后再设置布局。
    NSTimeInterval  timeIntervalValue;
    
    //------------------------------------------
    
    
}
/** 
 *  缓存目标视图的布局数据
 *  @param 键盘的显示和隐藏是成对的
 */
@property (nullable, nonatomic, strong) NSMutableDictionary<NSString *, CGKeyboardCacheModel *> *targetViewLayoutCache;

@end

@implementation CGKeyboardManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _constraintConstantType     = CGKeyboardConstraintConstantTypeLess;
        _keyboardChangeFrameType    = CGKeyboardChangeFrameTypeSize;
    }
    return self;
}

#pragma mark - 键盘通知处理
- (void)handleKeyboardShowHideNotification:(NSNotification *)note
{
    
    NSDate *currentDate     = [NSDate date];
    if (oldSendNotificationDate) {
        timeIntervalValue   = [currentDate timeIntervalSinceDate:oldSendNotificationDate];
    }
    oldSendNotificationDate = currentDate;
    
    BOOL isDealWith     = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardManager:shouldDealWithNotification:)]) {
        isDealWith      = [self.delegate keyboardManager:self shouldDealWithNotification:note];
    }
    
    if (!isDealWith) {
        return;
    }
    
    BOOL isShowKeyboardMark;
    NSString *noteName  = note.name;
    if ([noteName isEqualToString:UIKeyboardWillShowNotification] || [noteName isEqualToString:UIKeyboardDidShowNotification]) {
        
        if (![self handleKeyboardShowNotification:note]) {
            return;
        }
        isShowKeyboardMark  = YES;
    }else if ([noteName isEqualToString:UIKeyboardWillHideNotification] || [noteName isEqualToString:UIKeyboardDidHideNotification]) {
        
        if (![self handleKeyboardHideNotification:note]) {
            return;
        }
        isShowKeyboardMark  = NO;
    }
    
    //设置需要改变frame的视图
    UIView *theNeedChangeFrameTheView                   = nil;
    NSLayoutConstraint *bottomLayoutConstraint          = nil;
    CGFloat bottomConstraintConstant                    = 0;
    //设置需要改变的frame值
    CGRect keyboardFrameDidChangeNeedChangeViewFrame    = CGRectZero;
    if (isShowKeyboardMark) {
        
        //显示时
        theNeedChangeFrameTheView   = [self setupNeedChangeFrameTheViewWithNotification:note];
        bottomLayoutConstraint      = [self setupBottomLayoutConstraintWithNotification:note needChangeFrameView:theNeedChangeFrameTheView];
        keyboardFrameDidChangeNeedChangeViewFrame   = [self setupFrameWithNeedChangeFrameTheView:theNeedChangeFrameTheView notification:note];
        bottomConstraintConstant    = [self setupBottomLayoutConstraintConstantWithNeedChangeFrameTheView:theNeedChangeFrameTheView notification:note bottomConstraint:bottomLayoutConstraint];
        CGKeyboardCacheModel *cacheModel    = [self.targetViewLayoutCache objectForKey:note.name];
        
        if (!cacheModel) {
            //当键盘显示时，且没有纪录过当前view时纪录下这个view原始的状态
            cacheModel  = [[CGKeyboardCacheModel alloc] init];
            cacheModel.targetView               = theNeedChangeFrameTheView;
            cacheModel.targetLayoutConstraint   = bottomLayoutConstraint;
            cacheModel.originalConstant         = bottomLayoutConstraint.constant;
            cacheModel.originalFrame            = theNeedChangeFrameTheView.frame;
            cacheModel.keyboardNotificationType = [self typeForNotificationName:note.name];
            
            if (self.targetViewLayoutCache) {
                
                [self.targetViewLayoutCache setObject:cacheModel forKey:note.name];
            }else {
                
                self.targetViewLayoutCache  = [NSMutableDictionary dictionaryWithObject:cacheModel forKey:note.name];
            }
        }
    }else {
        
        NSString *key   = nil;
        if ([note.name isEqualToString:UIKeyboardWillHideNotification]) {
            key = UIKeyboardWillShowNotification;
        }else if ([note.name isEqualToString:UIKeyboardDidHideNotification]) {
            key = UIKeyboardDidShowNotification;
        }
        
        if (key) {
            
            //隐藏时
            CGKeyboardCacheModel *cacheModel    = [self.targetViewLayoutCache objectForKey:key];
            theNeedChangeFrameTheView   = cacheModel.targetView;
            bottomConstraintConstant    = cacheModel.originalConstant;
            bottomLayoutConstraint      = cacheModel.targetLayoutConstraint;
            keyboardFrameDidChangeNeedChangeViewFrame   = cacheModel.originalFrame;
            [self.targetViewLayoutCache removeObjectForKey:key];
        }
    }
    
    if (bottomLayoutConstraint) {
        
        CGFloat constant    = bottomLayoutConstraint.constant - bottomConstraintConstant;
        if (constant > -CGZeroFloatValue && constant < CGZeroFloatValue) {
            return;
        }
        bottomLayoutConstraint.constant  =  bottomConstraintConstant;
        [theNeedChangeFrameTheView.superview setNeedsUpdateConstraints];
    }else {
        if (CGRectEqualToRect(theNeedChangeFrameTheView.frame, keyboardFrameDidChangeNeedChangeViewFrame)) {
            return;
        }
    }
    
    if (self.hideKeyboardShowHideAnimated) {
        
        if (!bottomLayoutConstraint) {
            
            theNeedChangeFrameTheView.frame = keyboardFrameDidChangeNeedChangeViewFrame;
        }else {
            //应使用父视图来视图更新结构
            UIView *view    = theNeedChangeFrameTheView.superview;
            [view layoutIfNeeded];
        }
        
        if ([note.name isEqualToString:UIKeyboardWillShowNotification] || [note.name isEqualToString:UIKeyboardDidShowNotification]) {
            [self scrollingToTargetViewWithNotification:note];
        }
    }else {
        
        NSTimeInterval duration = [self getKeyboardDuration:note];
        NSUInteger curve        = note.keyboardCurve;
        
        [UIView animateWithDuration:duration delay:0 options:curve animations:^{
            
            if (!bottomLayoutConstraint) {
                
                theNeedChangeFrameTheView.frame = keyboardFrameDidChangeNeedChangeViewFrame;
            }else {
                //应使用父视图来视图更新结构
                UIView *view    = theNeedChangeFrameTheView.superview;
                [view layoutIfNeeded];
            }
            
            if ([self.delegate respondsToSelector:@selector(keyboardManager:animationsNotification:)]) {
                [self.delegate keyboardManager:self animationsNotification:note];
            }
            
        } completion:^(BOOL finished) {
            
            if ([note.name isEqualToString:UIKeyboardWillShowNotification] || [note.name isEqualToString:UIKeyboardDidShowNotification]) {
                [self scrollingToTargetViewWithNotification:note];
            }
            
            if ([self.delegate respondsToSelector:@selector(keyboardManager:animationCompletionNotification:)]) {
                [self.delegate keyboardManager:self animationCompletionNotification:note];
            }
        }];
    }
    
}

//返回是否向下执行 YES向下执行
- (BOOL)handleKeyboardShowNotification:(NSNotification *)note
{
    BOOL didShowDealWith    = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardManager:showKeyboardNotification:)]) {
        [self.delegate keyboardManager:self showKeyboardNotification:note];
        
        if ([self.delegate respondsToSelector:@selector(keyboardManager:didShowKeyboardDealWithNotification:)]) {
            didShowDealWith = [self.delegate keyboardManager:self didShowKeyboardDealWithNotification:note];
        }else {
            didShowDealWith = self.didShowKeyboardContinueDealWithNotification;
        }
    }
    
    return didShowDealWith;
}

//返回是否向下执行
- (BOOL)handleKeyboardHideNotification:(NSNotification *)note
{
    BOOL didHideDealWith    = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardManager:hideKeyboardNotification:)]) {
        
        [self.delegate keyboardManager:self hideKeyboardNotification:note];
        
        if ([self.delegate respondsToSelector:@selector(keyboardManager:didHideKeyboardDealWithNotification:)]) {
            didHideDealWith = [self.delegate keyboardManager:self didHideKeyboardDealWithNotification:note];
        }else {
            didHideDealWith = self.didHideKeyboardContinueDealWithNotification;
        }
    }
    
    return didHideDealWith;
}

- (CGKeyboardNotificationType)typeForNotificationName:(NSString *)name
{
    CGKeyboardNotificationType notificationType = 0;
    if ([name isEqualToString:UIKeyboardWillShowNotification]) {
        notificationType    = CGKeyboardNotificationTypeWillShow;
    }else if ([name isEqualToString:UIKeyboardDidShowNotification]) {
        notificationType    = CGKeyboardNotificationTypeDidShow;
    }else if ([name isEqualToString:UIKeyboardWillHideNotification]) {
        notificationType    = CGKeyboardNotificationTypeWillHide;
    }else if ([name isEqualToString:UIKeyboardDidHideNotification]) {
        notificationType    = CGKeyboardNotificationTypeDidHide;
    }
    return notificationType;
}

//- (CGKeyboardLayoutType)layoutType
//{
//    CGKeyboardLayoutType layoutType = self.keyboardLayoutType;
//    
//    if (layoutType == CGKeyboardLayoutTypeAuto) {
//        
//        if (self.keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint || [self.delegate respondsToSelector:@selector(targetViewBottomConstraintWithKeyboardManager:notification:needChangeFrameTheView:)]) {
//            layoutType  = CGKeyboardLayoutTypeLayout;
//        }else {
//            layoutType  = CGKeyboardLayoutTypeAutomaticLayout;
//        }
//    }
//    return layoutType;
//}

#pragma mark - 通知处理过程中的设置
- (UIView *)setupNeedChangeFrameTheViewWithNotification:(NSNotification *)note
{
    UIView *theNeedChangeFrameTheView   = nil;
    if ([self.delegate respondsToSelector:@selector(needChangeFrameTheViewWithKeyboardManager:notification:)]) {
        theNeedChangeFrameTheView   = [self.delegate needChangeFrameTheViewWithKeyboardManager:self notification:note];
    }else {
        theNeedChangeFrameTheView   = self.keyboardFrameDidChangeTheNeedToChangeFrameTheView;
    }
    return theNeedChangeFrameTheView;
}

- (NSLayoutConstraint *)setupBottomLayoutConstraintWithNotification:(NSNotification *)note needChangeFrameView:(UIView *)needChangeFrameView
{
    NSLayoutConstraint *bottomLayoutConstraint  = nil;
    if ([self.delegate respondsToSelector:@selector(targetViewBottomConstraintConstantWithKeyboardManager:notification:keyboardRect:needChangeFrameTheView:)]) {
        bottomLayoutConstraint  = [self.delegate targetViewBottomConstraintWithKeyboardManager:self notification:note needChangeFrameTheView:needChangeFrameView];
    }else {
        bottomLayoutConstraint  = self.keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint;
    }
    return bottomLayoutConstraint;
}

- (CGRect)setupFrameWithNeedChangeFrameTheView:(UIView *)theNeedChangeFrameTheView notification:(NSNotification *)note
{
    CGRect keyboardRect = note.keyboardFrame;
    CGRect keyboardFrameDidChangeNeedChangeViewFrame    = theNeedChangeFrameTheView.frame;
    
    if ([self.delegate respondsToSelector:@selector(targetViewFrameWithKeyboardManager:notification:keyboardRect:needChangeFrameTheView:)]) {
        
        keyboardFrameDidChangeNeedChangeViewFrame   = [self.delegate targetViewFrameWithKeyboardManager:self notification:note keyboardRect:keyboardRect needChangeFrameTheView:theNeedChangeFrameTheView];
    }else {
        
        //键盘显示区域在需要改变的视图的父视图中的区域
        
        CGFloat bottomSpace = [self setupTargetViewBottomSpaceWithView:theNeedChangeFrameTheView notification:note];
        
        CGKeyboardChangeFrameType keyboardChangeFrameType;
        if ([self.delegate respondsToSelector:@selector(changeFrameTypeWithKeyboardManager:needChangeFrameTheView:)]) {
            keyboardChangeFrameType = [self.delegate changeFrameTypeWithKeyboardManager:self needChangeFrameTheView:theNeedChangeFrameTheView];
        }else {
            keyboardChangeFrameType = self.keyboardChangeFrameType;
        }
        switch (keyboardChangeFrameType) {
            case CGKeyboardChangeFrameTypeSize:
                keyboardFrameDidChangeNeedChangeViewFrame.size.height   -= bottomSpace;
                break;
            case CGKeyboardChangeFrameTypeOrigin:
                keyboardFrameDidChangeNeedChangeViewFrame.origin.y      -= bottomSpace;
                break;
            default:
                break;
        }
    }
    
    return keyboardFrameDidChangeNeedChangeViewFrame;
}

- (CGFloat)setupBottomLayoutConstraintConstantWithNeedChangeFrameTheView:(UIView *)theNeedChangeFrameTheView notification:(NSNotification *)note bottomConstraint:(NSLayoutConstraint *)bottomConstraint
{
    CGRect keyboardRect = note.keyboardFrame;
    
    CGFloat bottomConstraintConstant    = bottomConstraint.constant;
    
    if ([self.delegate respondsToSelector:@selector(targetViewBottomConstraintConstantWithKeyboardManager:notification:keyboardRect:needChangeFrameTheView:)]) {
        bottomConstraintConstant    = [self.delegate targetViewBottomConstraintConstantWithKeyboardManager:self notification:note keyboardRect:keyboardRect needChangeFrameTheView:theNeedChangeFrameTheView];
    }else {
        
        if (theNeedChangeFrameTheView.superview && timeIntervalValue > CGZeroFloatValue && timeIntervalValue < [self getKeyboardDuration:note]) {
            //更新视图结构说明：
            //在iOS 10下，切换输入框时will show keyboard 会连续发送两次消息，这时第一次修改的值还没有生效，第二次用和第一次一样的视图结构重新计算一遍，导致设置的约束会出现问题，在这需要立即刷新，注意！这里刷的视图布局应为 指定视图的父视图
            UIView *view    = theNeedChangeFrameTheView.superview;
            [view setNeedsUpdateConstraints];
            [view layoutIfNeeded];
        }
        CGFloat bottomSpace = [self setupTargetViewBottomSpaceWithView:theNeedChangeFrameTheView notification:note];
        
        if (self.constraintConstantType == CGKeyboardConstraintConstantTypeLess) {
            bottomConstraintConstant    -= (bottomSpace);
        }else if (self.constraintConstantType == CGKeyboardConstraintConstantTypeAdd) {
            bottomConstraintConstant    += (bottomSpace);
        }
    }
    return bottomConstraintConstant;
}

/** 计算键盘与指定视图的底部之间的间距 */
- (CGFloat)setupTargetViewBottomSpaceWithView:(UIView *)theNeedChangeFrameTheView notification:(NSNotification *)note
{
    CGRect keyboardRect = note.keyboardFrame;
    
    //键盘显示区域在需要改变的视图的父视图中的区域
    
    UIView *overlayView = nil;
    if ([self.delegate respondsToSelector:@selector(overlayViewWithKeyboardManager:needChangeFrameTheView:)]) {
        overlayView = [self.delegate overlayViewWithKeyboardManager:self needChangeFrameTheView:theNeedChangeFrameTheView];
    }else {
        overlayView = theNeedChangeFrameTheView.superview;
    }
    
    CGRect  keyboardToTargetViewFrame           = [overlayView convertRect:keyboardRect fromView:nil];
    CGRect  theNeedChangeFrame;
    if (overlayView == theNeedChangeFrameTheView.superview) {
        
        theNeedChangeFrame  = theNeedChangeFrameTheView.frame;
    }else {
        
        theNeedChangeFrame  = [theNeedChangeFrameTheView.superview convertRect:theNeedChangeFrameTheView.frame toView:overlayView];
    }
    
    CGFloat targetViewMaxY              = CGRectGetMaxY(theNeedChangeFrame);
    CGFloat keyboardMinY                = CGRectGetMinY(keyboardToTargetViewFrame);
    
    CGFloat bottomSpace                 = targetViewMaxY - keyboardMinY;
    
    return bottomSpace;
}

#pragma mark - 获取动画属性值
- (NSTimeInterval)getKeyboardDuration:(NSNotification *)note
{
    NSTimeInterval duration;
    if (self.duration < CGZeroFloatValue) {
        duration    = note.keyboardDuration;
    }else {
        duration    = self.duration;
    }
    return duration;
}

#pragma mark - 设置键盘通知
- (void)addKeyboardNotificationName:(NSArray<NSString *> *)keyboardNotificationNameArray target:(nonnull id)target selector:(nonnull SEL)selector object:(nullable id)object
{
    [NSNotificationCenter addObserver:target selector:selector names:keyboardNotificationNameArray object:object];
}

- (void)removeKeyboardNotificationName:(NSArray<NSString *> *)keyboardNotificationNameArray target:(id)target object:(id)object
{
    [NSNotificationCenter removeObserver:target names:keyboardNotificationNameArray object:object];
}

#pragma mark - 输入文本通知

- (void)handleTextFieldTextDidChangeNotification:(NSNotification *)note
{
    BOOL isShouldScrolling  = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardManager:shouldScrollingWithTextField:)]) {
        isShouldScrolling   = [self.delegate keyboardManager:self shouldScrollingWithTextField:note.object];
    }
    
    if (isShouldScrolling) {
        [self scrollingWithFirstResponderView:note.object note:note];
    }
}

- (void)handleTextViewTextDidChangeNotification:(NSNotification *)note
{
    [self scrollingToTargetViewWithNotification:note];
}

#pragma mark - 滑动处理
- (void)scrollingToTargetViewWithNotification:(NSNotification *)note
{
    UIView  *firstResponderView = nil;
    if ([self.delegate respondsToSelector:@selector(firstResponderViewWithKeyboardManager:notification:)]) {
        firstResponderView  = [self.delegate firstResponderViewWithKeyboardManager:self notification:note];
    }else {
        firstResponderView  = self.firstResponderView;
    }
    
    if (!firstResponderView) {
        return;
    }
    
    [self scrollingWithFirstResponderView:firstResponderView note:note];
}

- (void)scrollingWithFirstResponderView:(UIView *)firstResponderView note:(NSNotification *)note
{
    if ([firstResponderView isKindOfClass:[UITextView class]]) {
        if (!self.enableFirstResponderIsUITextViewAutoScrolling) {
            return;
        }
    }
    UIScrollView *scrollView    = nil;
    
    if ([self.delegate respondsToSelector:@selector(scrollViewWithKeyboardManager:notification:)]) {
        scrollView  = [self.delegate scrollViewWithKeyboardManager:self notification:note];
    }else {
        scrollView  = self.scrollView;
    }
    
    if (!self.disableAutoSearchScrollView && !scrollView && firstResponderView) {
        
        scrollView  = [firstResponderView searchSuperViewWithClass:[UIScrollView class]];
    }
    
    if (scrollView && firstResponderView) {
        [scrollView scrollingWithTargetView:firstResponderView animated:!self.hideScrollAnimated];
    }
}

#pragma mark - 设置属性
- (void)setOpenKeyboardWillNotification:(BOOL)openKeyboardWillNotification
{
    if (_openKeyboardWillNotification != openKeyboardWillNotification) {
        
        _openKeyboardWillNotification   = openKeyboardWillNotification;
        if (openKeyboardWillNotification) {
            [NSNotificationCenter cg_addWillKeyboardObserver:self selector:@selector(handleKeyboardShowHideNotification:)];
        }else {
            [NSNotificationCenter cg_removeWillKeyboardObserver:self];
        }
    }
}

- (void)setOpenKeyboardDidNotification:(BOOL)openKeyboardDidNotification
{
    if (_openKeyboardDidNotification != openKeyboardDidNotification) {
        
        _openKeyboardDidNotification    = openKeyboardDidNotification;
        if (openKeyboardDidNotification) {
            [NSNotificationCenter cg_addKeyboardObserver:self selector:@selector(handleKeyboardShowHideNotification:)];
        }else {
            [NSNotificationCenter cg_removeKeyboardObserver:self];
        }
        
    }
}

- (UIView *)firstResponderView
{
    if (_firstResponderView) {
        return _firstResponderView;
    }
    
    _firstResponderView = [UIView cg_searchFirstResponder];
    return _firstResponderView;
}

- (void)setOpenTextFieldTextDidChangeNotification:(BOOL)openTextFieldTextDidChangeNotification
{
    if (_openTextFieldTextDidChangeNotification != openTextFieldTextDidChangeNotification) {
        
        _openTextFieldTextDidChangeNotification = openTextFieldTextDidChangeNotification;
        
        NSString *noteName  = UITextFieldTextDidChangeNotification;
        if (openTextFieldTextDidChangeNotification) {
            [NSNotificationCenter addObserver:self selector:@selector(handleTextFieldTextDidChangeNotification:) name:noteName];
        }else {
            [NSNotificationCenter removeObserver:self name:noteName];
        }
        
    }
}

//- (void)setOpenTextViewTextDidChangeNotification:(BOOL)openTextViewTextDidChangeNotification
//{
//    if (_openTextViewTextDidChangeNotification != openTextViewTextDidChangeNotification) {
//        
//        _openTextViewTextDidChangeNotification  = openTextViewTextDidChangeNotification;
//        
//        NSString *noteName  = UITextViewTextDidChangeNotification;
//        if (openTextViewTextDidChangeNotification) {
//            [NSNotificationCenter addObserver:self selector:@selector(handleTextViewTextDidChangeNotification:) name:noteName];
//        }else {
//            [NSNotificationCenter removeObserver:self name:noteName];
//        }
//    }
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    CGPrintClassNameLog()
}

@end
