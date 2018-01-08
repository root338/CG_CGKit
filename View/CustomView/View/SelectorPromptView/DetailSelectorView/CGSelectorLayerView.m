//
//  CGSelectorLayerView.m
//  TestCG_CGKit
//
//  Created by DY on 2016/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGSelectorLayerView.h"

#import "CGSelectorLayerAnimation.h"

#import "UIView+CGSearchView.h"
#import "UIView+CGSetupInteractivePopGestureRecognizerForNavigationController.h"

@interface CGSelectorLayerView ()<CAAnimationDelegate>
{
    //记录导航栏回退手势的状态
    BOOL interactivePopGestureRecognizerEnabledForNavigationController;
}

/** 动画的状态 */
@property (nonatomic, assign, readwrite) CGViewOperateStatus animationStatus;
/** contentView 的状态 */
@property (nonatomic, assign, readwrite) CGViewStatus contentViewStatus;

@end

@implementation CGSelectorLayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.disableBackgroundButtonTools   = YES;
        
        _fromBackgroundColor                = [UIColor clearColor];
        _toBackgroundColor                  = [UIColor colorWithWhite:0 alpha:0.5];
        self.backgroundColor                = _toBackgroundColor;
        
        _contentViewAnimationStyle          = CGSelectorLayerContentViewAniamtionStyleScale;
        _backgroundColorAnimationStyle      = CGSelectorLayerBackgroundColorAnimationsStyleDefalut;
        _disableInteractivePopGestureRecognizerForNavigationController  = YES;
    }
    return self;
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    [self didShow];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
}

- (void)show
{
    if (self.contentViewStatus == CGViewStatusShow || self.contentViewStatus == CGViewStatusHideToShow) {
        return;
    }
    
    [super show];
    [self setupNavigationControllerPopGestureRecognizerWithisShowContentViewAnimation:YES];
    
    CGSelectorLayerAnimationStyle showAnimationStyle    = CGSelectorLayerAnimationStyleNone;
    NSString *key                                       = nil;
    switch (self.contentViewAnimationStyle) {
        case CGSelectorLayerContentViewAniamtionStyleScale:
            showAnimationStyle  = CGSelectorLayerAnimationStyleScaleForShow;
            key                 = @"show.scale";
            break;
            
        default:
            break;
    }
    
    CAAnimation *animation  = [CGSelectorLayerAnimation createLayerAnimation:showAnimationStyle];
    animation.delegate      = self;
    animation == nil ?: [self.contentView.layer addAnimation:animation forKey:key];
    
    [self setupBackgroundColorWithIsShow:YES];
}

- (void)willShow
{
    
}

- (void)didShow
{
    
}

- (void)hide
{
    if (self.contentViewStatus == CGViewStatusHide || self.contentViewStatus == CGViewStatusShowToHide) {
        return;
    }
    
    [super hide];
    [self setupNavigationControllerPopGestureRecognizerWithisShowContentViewAnimation:NO];
    
//    CGSelectorLayerAnimationStyle hideAnimationStyle    = CGSelectorLayerAnimationStyleNone;
//    NSString *key                                       = nil;
    CAAnimation *animation                              = nil;
    switch (self.contentViewAnimationStyle) {
        case CGSelectorLayerContentViewAniamtionStyleScale:
        {
            
        }
            
            break;
            
        default:
            break;
    }
    
    if (animation == nil) {
        if (self.didHideContentViewRemoveSuperview) {
            [self removeFromSuperview];
        }
    }
}

- (void)setupBackgroundColorWithIsShow:(BOOL)isShow
{
    if (self.backgroundColorAnimationStyle == CGSelectorLayerBackgroundColorAnimationsStyleCustom) {
        if (self.backgroundColorAnimation == nil) {
            [self.layer addAnimation:self.backgroundColorAnimation forKey:nil];
        }
        return;
    }
    
    UIColor *fromColor  = nil;
    UIColor *toColor    = nil;
    if (isShow) {
        fromColor   = self.fromBackgroundColor;
        toColor     = self.toBackgroundColor;
    }else {
        fromColor   = self.toBackgroundColor;
        toColor     = self.fromBackgroundColor;
    }
    
    if (isShow == YES) {
        [self willShow];
    }
    
    if (self.backgroundColorAnimationStyle == CGSelectorLayerBackgroundColorAnimationsStyleDefalut) {
        //没反应
        CABasicAnimation *basicAniamtion    = [CGSelectorLayerAnimation createAnimationWithKeyPath:@"contents" fromValue:(id)[fromColor CGColor] toValue:(id)[toColor CGColor]];
        basicAniamtion.duration             = 0.3;
        [self.layer addAnimation:basicAniamtion forKey:nil];
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

@end
