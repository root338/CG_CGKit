//
//  CGKeyboardManager.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGKeyboardManager.h"

#import "NSNotification+CGKeyboardUserInfo.h"
#import "NSNotificationCenter+CGCreateNotification.h"


#import "UIView+CGSearchView.h"



@interface CGKeyboardManager ()

/** 
 *  缓存目标视图的布局数据
 *  @param 键盘的显示和隐藏是成对的
 */
@property (nullable, nonatomic, strong) NSMutableDictionary *targetViewLayoutCache;

@end

@implementation CGKeyboardManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _keyboardChangeFrameType    = CGKeyboardChangeFrameTypeSize;
    }
    return self;
}

#pragma mark - 键盘通知处理
- (void)handleKeyboardShowHideNotification:(NSNotification *)note
{
    BOOL isDealWith     = YES;
    if ([self.delegate respondsToSelector:@selector(keyboardManager:shouldDealWithNotification:)]) {
        isDealWith      = [self.delegate keyboardManager:self shouldDealWithNotification:note];
    }
    
    if (!isDealWith) {
        return;
    }
    
    NSString *noteName  = note.name;
    if ([noteName isEqualToString:UIKeyboardWillShowNotification] || [noteName isEqualToString:UIKeyboardDidShowNotification]) {
        
        if (![self handleKeyboardShowNotification:note]) {
            return;
        }
        
    }else if ([noteName isEqualToString:UIKeyboardWillHideNotification] || [noteName isEqualToString:UIKeyboardDidHideNotification]) {
        
        if (![self handleKeyboardHideNotification:note]) {
            return;
        }
    }
    
    //设置需要改变frame的视图
    UIView *theNeedChangeFrameTheView   = [self setupNeedChangeFrameTheViewWithNotification:note];
    
    CGFloat bottomConstraintConstant;
    //设置需要改变的frame值
    CGRect keyboardFrameDidChangeNeedChangeViewFrame    = [self setupFrameWithNeedChangeFrameTheView:theNeedChangeFrameTheView notification:note bottomConstraintConstant:&bottomConstraintConstant];
    
    NSTimeInterval duration;
    if (self.duration < 0.0001) {
        duration    = note.keyboardDuration;
    }else {
        duration    = self.duration;
    }
    
    NSUInteger curve    = note.keyboardCurve;
    
    if (self.keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint) {
        
        self.keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint.constant  = -(bottomConstraintConstant);
        [theNeedChangeFrameTheView setNeedsUpdateConstraints];
    }
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        
        if (!self.keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint) {
            
            theNeedChangeFrameTheView.frame = keyboardFrameDidChangeNeedChangeViewFrame;
        }else {
            
            [theNeedChangeFrameTheView layoutIfNeeded];
        }
        
        if ([self.delegate respondsToSelector:@selector(keyboardManager:animationsNotification:)]) {
            [self.delegate keyboardManager:self animationsNotification:note];
        }
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(keyboardManager:animationCompletionNotification:)]) {
            [self.delegate keyboardManager:self animationCompletionNotification:note];
        }
    }];
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

- (CGRect)setupFrameWithNeedChangeFrameTheView:(UIView *)theNeedChangeFrameTheView notification:(NSNotification *)note bottomConstraintConstant:(CGFloat *)bottomConstraintConstant
{
    CGRect keyboardRect = note.keyboardFrame;
    CGRect keyboardFrameDidChangeNeedChangeViewFrame;
    if ([self.delegate respondsToSelector:@selector(targetViewFrameWithKeyboardManager:notification:keyboardRect:needChangeFrameTheView:)]) {
        
        keyboardFrameDidChangeNeedChangeViewFrame   = [self.delegate targetViewFrameWithKeyboardManager:self notification:note keyboardRect:keyboardRect needChangeFrameTheView:theNeedChangeFrameTheView];
    }else {
        
        //键盘显示区域在需要改变的视图的父视图中的区域
        CGRect  keyboardToTargetViewFrame           = [theNeedChangeFrameTheView.superview convertRect:keyboardRect fromView:nil];
        CGRect  theNeedChangeFrame                  = theNeedChangeFrameTheView.frame;
        
        CGFloat targetViewMaxY              = CGRectGetMaxY(theNeedChangeFrame);
        CGFloat keyboardMinY                = CGRectGetMinY(keyboardToTargetViewFrame);
        
        CGFloat bottomSpace                 = targetViewMaxY - keyboardMinY;
        if (bottomSpace > 0) {
            
            theNeedChangeFrame.size.height  -= bottomSpace;
            *bottomConstraintConstant       = bottomSpace;
        }
        keyboardFrameDidChangeNeedChangeViewFrame   = theNeedChangeFrame;
    }
    return keyboardFrameDidChangeNeedChangeViewFrame;
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

#pragma mark - 设置属性
- (void)setOpenKeyboardWillNotification:(BOOL)openKeyboardWillNotification
{
    if (_openKeyboardWillNotification != openKeyboardWillNotification) {
        
        _openKeyboardWillNotification   = openKeyboardWillNotification;
        [NSNotificationCenter cg_addWillKeyboardObserver:self selector:@selector(handleKeyboardShowHideNotification:)];
    }
}

- (void)setOpenKeyboardDidNotification:(BOOL)openKeyboardDidNotification
{
    if (_openKeyboardDidNotification != openKeyboardDidNotification) {
        
        _openKeyboardDidNotification    = openKeyboardDidNotification;
        [NSNotificationCenter cg_addKeyboardObserver:self selector:@selector(handleKeyboardShowHideNotification:)];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
