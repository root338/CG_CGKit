//
//  UIView+CGLineMoveView.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGMoveViewTypeHeader.h"
#import "CGBlockHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^CGLineMoveViewBlock) (UIView *paramView);

/** 线性动画 */
@interface UIView (CGLineMoveView)

#pragma mark - 显示视图
/** 显示视图，不回调 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type;
/** 显示视图，仅回调 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type completion:(void(^ __nullable)(void))completion;

/**
 *  移动view到overlayView 动画默认时间为 1/3.0
 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation completion:(void(^ __nullable)(void))completion;

/**
 *  移动view到overlayView，回调
 *
 *  @param overlayView 参照视图，与view在同一个坐标系
 *  @param type        移动的边距
 *  @param animation   是否执行动画
 *  @param duration    动画时间
 *  @param completion  动画执行完毕回调
 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration completion:(void(^ __nullable)(void))completion;

//- (void)cg_showLineMoveWithType:(CGLineMoveViewType)type overlayView:(UIView *)overlayView overlayView:(CGLineMoveViewType)overlayView;

/** 移动视图，可设置更多视图属性 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion;

#pragma mark - 隐藏视图
/** 隐藏视图，不回调 */
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type;
/** 隐藏视图，仅回调 */
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type completion:(void(^ __nullable)(void))completion;

/**
 *  移动view到overlayView 动画默认时间为 1/3.0
 */
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation completion:(void(^ __nullable)(void))completion;

/** 移动视图，自动设置时间，回调 */
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration completion:(void(^ __nullable)(void))completion;

/**
 *  移动视图，可设置更多视图属性
 *  @param beforeAnimationBlock 动画开始前UIView的属性设置
 *  @param afterAnimationBlock  UIView最终的属性设置
 */
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration beforeAnimationBlock:(void(^ __nullable)(UIView *paramView))beforeAnimationBlock afterAnimationBlock:(void (^ __nullable)(UIView *paramView))afterAnimationBlock completion:(void(^)(void))completion;
@end
NS_ASSUME_NONNULL_END
