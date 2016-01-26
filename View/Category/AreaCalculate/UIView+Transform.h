//
//  UIView+Transform.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/13.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  设置UIView transform 属性
 */
@interface UIView (Transform)

/**
 *  旋转UIView 没有动画
 *
 *  @param angle 旋转的弧度
 */
- (void)rorationWithAngle:(CGFloat)angle;

/**
 *  旋转UIView 有动画
 *
 *  @param angle      旋转的弧度
 *  @param completion 动画结束的回调
 */
- (void)rorationWithAngle:(CGFloat)angle completion:(void(^)(BOOL finished))completion;

/**
 *  旋转UIView 有动画
 *
 *  @param angle      旋转的弧度
 *  @param duration   旋转的时间
 *  @param completion 动画结束时的回调
 */
- (void)rorationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;
@end
NS_ASSUME_NONNULL_END