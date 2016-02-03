//
//  UIView+CGScaleView.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGMoveViewTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 缩放视图动画，顶点以自身为参考 */
@interface UIView (CGScaleView)

#pragma mark - 缩放显示视图
/** 缩放显示视图，不回调 */
- (void)cg_showScaleWithType:(CGScaleViewType)type;
/** 缩放显示视图，仅回调 */
- (void)cg_showScaleWithType:(CGScaleViewType)type completion:(void(^ __nullable)(void))completion;

/**
 *  缩放显示view到overlayView，回调
 *
 *  @param view        需要移动的视图
 *  @param overlayView 参照视图，与view在同一个坐标系
 *  @param type        移动的边距
 *  @param animation   是否执行动画
 *  @param duration    动画时间
 *  @param completion  动画执行完毕回调
 */
- (void)cg_showScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration completion:(void(^ __nullable)(void))completion;

/** 缩放显示视图，可设置更多视图属性 */
- (void)cg_showScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion;

#pragma mark - 缩放隐藏视图
/** 缩放隐藏视图，不回调 */
- (void)cg_dismissScaleWithType:(CGScaleViewType)type;
/** 缩放隐藏视图，仅回调 动画默认时间为 1/3.0 */
- (void)cg_dismissScaleWithType:(CGScaleViewType)type completion:(void(^ __nullable)(void))completion;

/** 缩放隐藏视图，自动设置时间，回调 */
- (void)cg_dismissScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration completion:(void(^ __nullable)(void))completion;

/**
 *  缩放隐藏视图，可设置更多视图属性
 *  @param beforeAnimationBlock 动画开始前UIView的属性设置
 *  @param afterAnimationBlock  UIView最终的属性设置
 */
- (void)cg_dismissScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration beforeAnimationBlock:(void(^ __nullable)(UIView *paramView))beforeAnimationBlock afterAnimationBlock:(void (^ __nullable)(UIView *paramView))afterAnimationBlock completion:(void(^)(void))completion;

@end
NS_ASSUME_NONNULL_END