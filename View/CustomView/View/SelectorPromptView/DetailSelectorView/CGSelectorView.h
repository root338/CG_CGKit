//
//  CGBaseAlertContentView.h
//  QuickAskCommunity
//
//  Created by DY on 2016/11/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseView.h"
#import "CGSelectorTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class CGSelectorView;

typedef void (^CGSelectorAnimationBlock) (void);
typedef void (^CGSelectorAnimationCompletionBlock) (BOOL finished);

/** content view 的动画方式 */
typedef NS_ENUM(NSInteger, CGSelectorContentViewAnimationType) {
    /** 由底部向上 */
    CGSelectorContentViewAnimationTypeBottomToTop,
    /** 由顶部向下 */
    CGSelectorContentViewAnimationTypeTopToBottom,
    /** 由左向右 */
    CGSelectorContentViewAnimationTypeLeftToRight,
    /** 由右向左 */
    CGSelectorContentViewAnimationTypeRightToLeft,
};

/** 视图动画的效果 */
typedef NS_ENUM(NSInteger, CGSelectorViewAnimationsStyle) {
    /** 默认效果 */
    CGSelectorViewAnimationsStyleDefalut,
    /** 弹簧效果 */
    CGSelectorViewAnimationsStyleSpringEffect,
    
    /** 自定义动画效果，@warning 所有设置项全部失效，需要用户自定义实现 */
//    CGSelectorViewAnimationsStyleCustom,
};

/**
 弹层选择视图 使用UIView提供的animation动画方法
 内容选择器应该添加到contentView中
 */
@interface CGSelectorView : CGBaseView

#pragma mark - 视图设置
/** 选择的内容视图 */
@property (nonatomic, strong, readonly) UIView *contentView;

/** 立即更新 contentView 的布局，用于contentView的大小是由约束控制的 默认为 NO  */
@property (nonatomic, assign) BOOL isUpdateImmediatelyContentViewLayout;

/** 选择视图大小是否等于父视图的bounds属性, 默认为 YES */
@property (nonatomic, assign) BOOL frameEqualSuperviewBounds;

/** 隐藏contentView后移除父视图, 默认YES */
@property (nonatomic, assign) BOOL didHideContentViewRemoveSuperview;
/** 选择视图的父视图 */
@property (nullable, nonatomic, weak) UIView *targetSuperview;
/** 设置选择视图的父视图block */
@property (nullable, nonatomic, copy) UIView * (^setupSuperviewBlock) (void);

/** 
 关闭背景图按钮功能 默认NO
 触发- (void)hideContentView方法 
 */
@property (nonatomic, assign) BOOL disableBackgroundButtonTools;

/** 
 当显示选择视图时关闭导航栏的回退手势, 默认YES
 隐藏时自动设置为之前的值
 */
@property (nonatomic, assign) BOOL disableInteractivePopGestureRecognizerForNavigationController;

/** 关闭动画执行中的用户交互, 默认 NO */
@property (nonatomic, assign) BOOL disableAnimationUserInteraction;
/** 动画的状态 */
@property (nonatomic, assign, readonly) CGViewOperateStatus animationStatus;
/** contentView 的状态 */
@property (nonatomic, assign, readonly) CGViewStatus contentViewStatus;

#pragma mark - 背景设置
/** 动画执行选择视图背景色的改变，默认 YES */
@property (nonatomic, assign) BOOL animationChangeBackgroundColor;
/** 选择视图未显示时的颜色，默认 nil */
@property (nullable, nonatomic, strong) UIColor *fromBackgroundColor;
/** 选择视图显示时的颜色，默认 [UIColor colorWithWhite:0 alpha:0.5] */
@property (nullable, nonatomic, strong) UIColor *toBackgroundColor;

#pragma mark - 动画方式设置
/** 选择视图的动画效果类型, 默认 CGSelectorViewAnimationsStyleDefalut */
@property (nonatomic, assign) CGSelectorViewAnimationsStyle animationsStyle;

/** 选择内容视图的动画方式， 默认 CGSelectorContentViewAnimationTypeBottomToTop */
@property (nonatomic, assign) CGSelectorContentViewAnimationType contentViewAnimationType;
/** 动画执行时间，默认0.3 */
@property (nonatomic, assign) NSTimeInterval duration;
/** 选择视图显示时动画延迟执行时间, 默认0 */
@property (nonatomic, assign) NSTimeInterval delayForContentViewShow;
/** 选择视图隐藏时动画延迟执行时间, 默认0 */
@property (nonatomic, assign) NSTimeInterval delayForContentViewHide;
/** 选择视图显示时动画的实现方式， 默认 UIViewAnimationOptionCurveLinear */
@property (nonatomic, assign) UIViewAnimationOptions contentViewShowAnimationOptions;
/** 选择视图隐藏时动画的实现方式, 默认 UIViewAnimationOptionCurveLinear */
@property (nonatomic, assign) UIViewAnimationOptions contentViewHideAnimationOptions;

#pragma mark - 动画时的状态设置
/** 选择器在显示选择视图动画前的设置 */
@property (nullable, nonatomic, copy) CGSelectorAnimationBlock selectorWillShowAnimationsBlock;
/** 选择器在显示选择视图动画时的设置 */
@property (nullable, nonatomic, copy) CGSelectorAnimationBlock selectorSetupShowAnimationsBlock;
/** 选择器在隐藏选择视图动画前的设置 */
@property (nullable, nonatomic, copy) CGSelectorAnimationBlock selectorWillHideAnimationsBlock;
/** 选择器在隐藏选择视图动画时的设置 */
@property (nullable, nonatomic, copy) CGSelectorAnimationBlock selectorSetupHideAnimationsBlock;

/** 选择器在显示选择视图动画完成后调用 */
@property (nullable, nonatomic, copy) CGSelectorAnimationCompletionBlock selectorShowAnimationsCompletion;
/** 选择器在隐藏选择视图动画完成后调用 */
@property (nullable, nonatomic, copy) CGSelectorAnimationCompletionBlock selectorHideAnimationsCompletion;

#pragma mark - 弹簧效果下的属性值
/** 0.0 ~ 1.0 阻尼比例，数值越小「弹簧」的振动效果越明显, 默认 0.7 */
@property (nonatomic, assign) CGFloat springDampingRatio;
/** 初始的速度，数值越大一开始移动越快, 默认 3.0 */
@property (nonatomic, assign) CGFloat initialSpringVelocity;

#pragma mark - 动画执行方法

- (void)showContentView;
- (void)hideContentView;

@end

NS_ASSUME_NONNULL_END
