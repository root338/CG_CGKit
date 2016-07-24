//
//  UIView+Animation.h
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置动画显隐时的方式
 */
typedef NS_ENUM(NSInteger, ShowHideAnimationType){
    /**
     *  从下到上
     */
    ShowHideAnimationTypeFromBottom,
    /**
     *  从上到下
     */
    ShowHideAnimationTypeFromTop,
    /**
     *  从左到右
     */
    ShowHideAnimationTypeFromLeft,
    /**
     *  从右到左
     */
    ShowHideAnimationTypeFromRight,
};

/**
 *  视图动画处理类 ---- 显示隐藏动画
 *  @warning 该扩展方法必须在视图的坐标明确下使用
 */
@interface UIView (ShowOrHideAnimation)

/**
 *  该方法用于显示视图
 *
 *  @param duration      动画需要的用时
 *  @param animationType 动画的执行类型
 *  @param completion    动画结束的回调block
 */
- (void)showViewDuration:(CGFloat)duration animationType:(ShowHideAnimationType)animationType completion:(void (^)(BOOL finished))completion;

/**
 *  该方法用于隐藏视图
 *
 *  @param duration      动画需要的用时
 *  @param animationType 动画的执行类型
 *  @param completion    动画结束的回调block
 */
- (void)hideViewDuration:(CGFloat)duration animationType:(ShowHideAnimationType)animationType completion:(void (^)(BOOL finished))completion;

/**
 *  该方法用于显示隐藏视图
 *
 *  @param isShow        视图视图隐藏
 *  @param duration      动画需要的用时
 *  @param animationType 动画的执行类型
 *  @param completion    动画结束的回调block @warning 在视图结束位置与当前位置一致时 completion block 回调的 finished值为 NO
 */
- (void)switchingViewIsShow:(BOOL)isShow duration:(CGFloat)duration animationType:(ShowHideAnimationType)animationType completion:(void (^)(BOOL finished))completion;
@end
