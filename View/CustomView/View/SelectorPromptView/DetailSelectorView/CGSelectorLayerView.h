//
//  CGSelectorLayerView.h
//  TestCG_CGKit
//
//  Created by DY on 2016/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseSelectorView.h"
#import "CGSelectorTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSInteger, CGSelectorLayerAniamtionsType) {
//    
//    CGSelectorLayerAniamtionsType
//};

/** 选择视图的背景色动画样式  */
typedef NS_ENUM(NSInteger, CGSelectorLayerBackgroundColorAnimationsStyle) {
    
    /** 没有动画 */
    CGSelectorLayerBackgroundColorAnimationsStyleNone,
    /** 默认的，0.3秒色值渐变 */
    CGSelectorLayerBackgroundColorAnimationsStyleDefalut,
    /** 自定义 */
    CGSelectorLayerBackgroundColorAnimationsStyleCustom,
};

/** 选择视图的 contentView 的动画样式 */
typedef NS_ENUM(NSInteger, CGSelectorLayerContentViewAniamtionStyle) {
    
    /** 没有动画效果  */
    CGSelectorLayerContentViewAniamtionStyleNone,
    
    /** 缩放 防 UIAlertView 的动画效果 */
    CGSelectorLayerContentViewAniamtionStyleScale,
};

/**
 弹层动画，使用CALayer进行动画
 */
@interface CGSelectorLayerView : CGBaseSelectorView

@property (nonatomic, assign) CGSelectorLayerContentViewAniamtionStyle contentViewAnimationStyle;

/**
 当显示选择视图时关闭导航栏的回退手势, 默认YES
 隐藏时自动设置为之前的值
 */
@property (nonatomic, assign) BOOL disableInteractivePopGestureRecognizerForNavigationController;

/** 关闭动画执行中的用户交互, 默认 NO */
@property (nonatomic, assign) BOOL disableAnimationUserInteraction;
/** 动画的状态 */
@property (nonatomic, assign, readonly) CGViewAnimationStatus animationStatus;
/** contentView 的状态 */
@property (nonatomic, assign, readonly) CGViewStatus contentViewStatus;

#pragma mark - 背景色的设置

@property (nonatomic, assign) CGSelectorLayerBackgroundColorAnimationsStyle backgroundColorAnimationStyle;
@property (nullable, nonatomic, strong) UIColor *toBackgroundColor;
@property (nullable, nonatomic, strong) UIColor *fromBackgroundColor;

@property (nullable, nonatomic, strong) CAAnimation *backgroundColorAnimation;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
