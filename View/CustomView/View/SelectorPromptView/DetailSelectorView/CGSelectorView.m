//
//  CGBaseAlertContentView.m
//  QuickAskCommunity
//
//  Created by DY on 2016/11/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGSelectorView.h"

#import "UIView+CGUpdateViewLayout.h"
#import "UIView+CGSetupInteractivePopGestureRecognizerForNavigationController.h"

#import "CGPrintLogHeader.h"

@interface CGSelectorView ()
{
    /*! 标识是否刷新contentView视图，isUpdateImmediatelyContentViewLayout 必须 = YES */
    BOOL isDidUpdateContentViewLayout;
    
    UIButton *cancelButton;
    //记录导航栏回退手势的状态
    BOOL interactivePopGestureRecognizerEnabledForNavigationController;
}

@property (nonatomic, strong, readwrite) UIView *contentView;

/** 动画的状态 */
@property (nonatomic, assign, readwrite) CGViewAnimationStatus animationStatus;
/** contentView 的状态 */
@property (nonatomic, assign, readwrite) CGViewStatus contentViewStatus;
@end

@implementation CGSelectorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView    = [[UIView alloc] init];
        
        _disableBackgroundButtonTools       = NO;
        _didHideContentViewRemoveSuperview  = YES;
        _frameEqualSuperviewBounds          = YES;
        _animationChangeBackgroundColor     = YES;
        _animationsStyle                    = CGSelectorViewAnimationsStyleDefalut;
        _contentViewAnimationType           = CGSelectorContentViewAnimationTypeBottomToTop;
        _fromBackgroundColor                = nil;
        _toBackgroundColor                  = [UIColor colorWithWhite:0 alpha:0.5];
        
        _duration                           = 0.3;
        _delayForContentViewShow            = 0;
        _delayForContentViewHide            = 0;
        _contentViewShowAnimationOptions    = UIViewAnimationOptionCurveLinear;
        _contentViewHideAnimationOptions    = UIViewAnimationOptionCurveLinear;
        
        _disableAnimationUserInteraction    = NO;
        _animationStatus    = CGViewAnimationStatusStill;
        _contentViewStatus  = CGViewStatusHide;
        _disableInteractivePopGestureRecognizerForNavigationController  = YES;
        
        _springDampingRatio                 = 0.7;
        _initialSpringVelocity              = 3.0;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.contentView.superview ?: [self addSubview:_contentView];
    }
}

- (void)showContentView
{
    [self showContentViewWithAnimatinType:self.contentViewAnimationType];
}

- (void)hideContentView
{
    [self hideContentViewWithAnimationType:self.contentViewAnimationType];
}

- (void)showContentViewWithAnimatinType:(CGSelectorContentViewAnimationType)animationType
{
    if (self.contentViewStatus == CGViewStatusShow || self.contentViewStatus == CGViewStatusHideToShow) {
        return;
    }
    
    [self setupSelfLayout];
    [self setupNavigationControllerPopGestureRecognizerWithisShowContentViewAnimation:YES];
    
    [self setupBackgroundColorWithIsShow:YES animations:NO];
    
    self.contentView.frame  = [self setupContentViewFrameWithAnimationType:animationType showContentView:NO];
    
    if (self.selectorWillShowAnimationsBlock) {
        self.selectorWillShowAnimationsBlock();
    }
    
    __weak __block typeof(self) weakself = self;
    CGSelectorAnimationBlock animations = ^{
        [weakself setupShowContentViewAnimationsWithType:animationType];
    };
    CGSelectorAnimationCompletionBlock completion = ^(BOOL finished){
        [weakself setupShowContentViewAnimationsCompletions:finished];
    };
    
    if (self.animationsStyle == CGSelectorViewAnimationsStyleDefalut) {
        [UIView animateWithDuration:self.duration delay:self.delayForContentViewShow options:self.contentViewShowAnimationOptions animations:animations completion:completion];
    }else if (self.animationsStyle == CGSelectorViewAnimationsStyleSpringEffect) {
        [UIView animateWithDuration:self.duration delay:self.delayForContentViewShow usingSpringWithDamping:self.springDampingRatio initialSpringVelocity:self.initialSpringVelocity options:self.contentViewShowAnimationOptions animations:animations completion:completion];
    }
}

//显示选择视图动画时的属性变化设置
- (void)setupShowContentViewAnimationsWithType:(CGSelectorContentViewAnimationType)animationType
{
    [self setupBackgroundColorWithIsShow:YES animations:YES];
    self.contentView.frame  = [self setupContentViewFrameWithAnimationType:animationType showContentView:YES];
    
    if (self.selectorSetupShowAnimationsBlock) {
        self.selectorSetupShowAnimationsBlock();
    }
    
    self.contentViewStatus  = CGViewStatusHideToShow;
    self.animationStatus    = CGViewAnimationStatusAniamtion;
}
//显示选择视图动画完成时的设置
- (void)setupShowContentViewAnimationsCompletions:(BOOL)finished
{
    if (self.selectorShowAnimationsCompletion) {
        self.selectorShowAnimationsCompletion(finished);
    }
    
    self.contentViewStatus  = CGViewStatusShow;
    self.animationStatus    = CGViewAnimationStatusStill;
}

- (void)hideContentViewWithAnimationType:(CGSelectorContentViewAnimationType)animationType
{
    if (self.contentViewStatus == CGViewStatusShowToHide || self.contentViewStatus == CGViewStatusHide) {
        return;
    }
    
    [self setupNavigationControllerPopGestureRecognizerWithisShowContentViewAnimation:NO];
    [self setupBackgroundColorWithIsShow:NO animations:NO];
    
    if (self.selectorWillHideAnimationsBlock) {
        self.selectorWillHideAnimationsBlock();
    }
    
    __weak __block typeof(self) weakself = self;
    CGSelectorAnimationBlock animations = ^{
        [weakself setupHideContentViewAnimationsWithType:animationType];
    };
    CGSelectorAnimationCompletionBlock completion = ^(BOOL finished){
        [weakself setupHideContentViewAnimationsCompletions:finished];
    };
    
    if (self.animationsStyle == CGSelectorViewAnimationsStyleDefalut) {
        [UIView animateWithDuration:self.duration delay:self.delayForContentViewHide options:self.contentViewHideAnimationOptions animations:animations completion:completion];
    }else if (self.animationsStyle == CGSelectorViewAnimationsStyleSpringEffect) {
        [UIView animateWithDuration:self.duration delay:self.delayForContentViewHide usingSpringWithDamping:self.springDampingRatio initialSpringVelocity:self.initialSpringVelocity options:self.contentViewHideAnimationOptions animations:animations completion:completion];
    }
}

//显示选择视图动画时的属性变化设置
- (void)setupHideContentViewAnimationsWithType:(CGSelectorContentViewAnimationType)animationType
{
    [self setupBackgroundColorWithIsShow:NO animations:YES];
    self.contentView.frame  = [self setupContentViewFrameWithAnimationType:animationType showContentView:NO];
    
    if (self.selectorSetupHideAnimationsBlock) {
        self.selectorSetupHideAnimationsBlock();
    }
    
    self.contentViewStatus  = CGViewStatusShowToHide;
    self.animationStatus    = CGViewAnimationStatusAniamtion;
}
//隐藏选择视图动画完成时的设置
- (void)setupHideContentViewAnimationsCompletions:(BOOL)finished
{
    if (self.selectorHideAnimationsCompletion) {
        self.selectorHideAnimationsCompletion(finished);
    }
    
    self.contentViewStatus  = CGViewStatusHide;
    self.animationStatus    = CGViewAnimationStatusStill;
    
    if (self.didHideContentViewRemoveSuperview) {
        [self removeFromSuperview];
    }
}

/**
 设置contentView的显示区域
 @warning 改方法仅修改必需的属性值，不会修改其他不相关的属性值

 @param animationType 动画执行的方式
 @param isShowContentView 是否显示contentView
 @return 返回contentView的显示区域
 */
- (CGRect)setupContentViewFrameWithAnimationType:(CGSelectorContentViewAnimationType)animationType showContentView:(BOOL)isShowContentView
{
    if (self.isUpdateImmediatelyContentViewLayout) {
        if (!isDidUpdateContentViewLayout) {
            [self.contentView cg_viewUpdateContentLayoutIfNeeded];
            isDidUpdateContentViewLayout    = YES;
        }
    }
    
    CGFloat originX = 0, originY = 0;
    
    CGFloat width   = self.width;
    CGFloat height  = self.height;
    
    CGFloat contentViewWidth = self.contentView.width;
    CGFloat contentViewHeight = self.contentView.height;
    
    if (animationType == CGSelectorContentViewAnimationTypeBottomToTop || animationType == CGSelectorContentViewAnimationTypeTopToBottom) {
        originX = self.contentView.xOrigin;
    }else if (animationType == CGSelectorContentViewAnimationTypeRightToLeft || animationType == CGSelectorContentViewAnimationTypeLeftToRight) {
        originY = self.contentView.yOrigin;
    }
    
    switch (animationType) {
        case CGSelectorContentViewAnimationTypeBottomToTop:
        {
            if (isShowContentView) {
                originY = height - contentViewHeight;
            }else {
                originY = height;
            }
        }
            break;
        case CGSelectorContentViewAnimationTypeTopToBottom:
        {
            if (isShowContentView) {
                originY = 0;
            }else {
                originY = -contentViewHeight;
            }
        }
            break;
        case CGSelectorContentViewAnimationTypeLeftToRight:
        {
            if (isShowContentView) {
                originX = 0;
            }else {
                originX = -contentViewWidth;
            }
        }
            break;
        case CGSelectorContentViewAnimationTypeRightToLeft:
        {
            if (isShowContentView) {
                originX = width - contentViewWidth;
            }else {
                originX = width;
            }
        }
            break;
        default:
            break;
    }
    
    return CGRectMake(originX, originY, contentViewWidth, contentViewHeight);
}

/**
 修改视图的背景色

 @param isShow 是否是显示 contentView 时的动画
 @param animations 是否在动画中 isShow
 */
- (void)setupBackgroundColorWithIsShow:(BOOL)isShow animations:(BOOL)animations
{
    UIColor *backgroundColor    = nil;
    if (self.animationChangeBackgroundColor) {
        if (animations) {
            if (isShow) {
                backgroundColor = self.toBackgroundColor;
            }else {
                backgroundColor = self.fromBackgroundColor;
            }
        }else {
            if (isShow) {
                backgroundColor = self.fromBackgroundColor;
            }else {
                backgroundColor = self.toBackgroundColor;
            }
        }
    }else {
        if (animations) {
            return;
        }else {
            if (isShow) {
                backgroundColor = self.toBackgroundColor;
            }else {
                backgroundColor = self.fromBackgroundColor;
            }
        }
    }
    self.backgroundColor    = backgroundColor;
}

#pragma mark - 设置视图

- (void)setupSelfLayout
{
    if (self.superview == nil) {
        UIView *targetSuperview = nil;
        if (self.setupSuperviewBlock) {
            targetSuperview = self.setupSuperviewBlock();
        }else {
            targetSuperview = self.targetSuperview;
        }
        CGDebugAssert(targetSuperview, @"请设置选择视图的父视图");
        [targetSuperview addSubview:self];
        if (self.frameEqualSuperviewBounds) {
            
            if (!CGRectEqualToRect(self.frame, targetSuperview.bounds)) {
                self.frame  = targetSuperview.bounds;
                isDidUpdateContentViewLayout    = NO;
            }
        }
    }
    
    [self setupCancelButton];
}

- (void)setupCancelButton
{
    if (!self.disableBackgroundButtonTools) {
        if (cancelButton == nil) {
            cancelButton    = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelButton.frame  = self.bounds;
            [cancelButton addTarget:self action:@selector(handleCancelAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (cancelButton.superview == nil) {
            
            if (self.contentView.superview == nil) {
                [self addSubview:cancelButton];
            }else {
                [self insertSubview:cancelButton belowSubview:self.contentView];
            }
        }
    }
}

- (void)setupNavigationControllerPopGestureRecognizerWithisShowContentViewAnimation:(BOOL)isShowContentViewAnimation
{
    if (!self.disableInteractivePopGestureRecognizerForNavigationController) {
        return;
    }
    
    if (isShowContentViewAnimation) {
        interactivePopGestureRecognizerEnabledForNavigationController   = [self setupNavigationControllerInteractivePopGestureRecognizerWithEnable:NO];
    }else {
        [self setupNavigationControllerInteractivePopGestureRecognizerWithEnable:interactivePopGestureRecognizerEnabledForNavigationController];
    }
}

#pragma mark - 事件处理
- (void)handleCancelAction:(id)sender
{
    [self hideContentView];
}

#pragma mark - 系统方法重写
- (void)layoutSubviews
{
    [super layoutSubviews];
    cancelButton.frame  = self.bounds;
}

#pragma mark - 设置属性
- (void)setAnimationStatus:(CGViewAnimationStatus)animationStatus
{
    _animationStatus    = animationStatus;
    if (self.disableAnimationUserInteraction) {
        
        BOOL userInteractionEnabled = YES;
        if (animationStatus == CGViewAnimationStatusAniamtion) {
            userInteractionEnabled  = NO;
        }
        self.userInteractionEnabled = userInteractionEnabled;
    }
}

- (void)setDisableBackgroundButtonTools:(BOOL)disableBackgroundButtonTools
{
    _disableBackgroundButtonTools   = disableBackgroundButtonTools;
    cancelButton.enabled            = disableBackgroundButtonTools;
}

@end
