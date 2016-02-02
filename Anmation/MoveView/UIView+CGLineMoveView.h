//
//  UIView+CGLineMoveView.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGLineMoveViewType) {
    
    CGLineMoveViewTypeTop,
    CGLineMoveViewTypeRight,
    CGLineMoveViewTypeBottom,
    CGLineMoveViewTypeLeft,
};

NS_ASSUME_NONNULL_BEGIN

/** 线性动画 */
@interface UIView (CGLineMoveView)

#pragma mark - 显示视图
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type;
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type completion:(void(^ __nullable)(void))completion;

/**
 *  移动view到overlayView 动画默认时间为 1/3.0
 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation completion:(void(^ __nullable)(void))completion;

/**
 *  移动view到overlayView
 *
 *  @param view        需要移动的视图
 *  @param overlayView 参照视图，与view在同一个坐标系
 *  @param type        移动的边距
 *  @param animation   是否执行动画
 *  @param duration    动画时间
 *  @param completion  动画执行完毕回调
 */
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration completion:(void(^ __nullable)(void))completion;

#pragma mark - 隐藏视图
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type;
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type completion:(void(^ __nullable)(void))completion;

/**
 *  移动view到overlayView 动画默认时间为 1/3.0
 */
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation completion:(void(^ __nullable)(void))completion;

- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration completion:(void(^ __nullable)(void))completion;
@end
NS_ASSUME_NONNULL_END