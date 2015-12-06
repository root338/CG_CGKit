//
//  UIView+CGAnimated.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBlockdDefinitionHeader.h"

/** 动画操作 */
@interface UIView (CGAnimated)

/** 改变视图属性(如果有动画，默认0.3s) */
- (void)changeStatusWithIsAnimated:(BOOL)isAnimated animations:(void (^ __nullable)(void))animatons;

/** 改变视图属性 */
- (void)changeStatusWithIsAnimated:(BOOL)isAnimated duration:(NSTimeInterval)duration animations:(void (^ __nullable)(void))animatons;

/**
 *  改变视图属性
 *
 *  @param isAnimated 是否动画
 *  @param duration   执行动画的时间
 *  @param animatons  设置的值
 *  @param completion 动画结束的回调
 */
- (void)changeStatusWithIsAnimated:(BOOL)isAnimated duration:(NSTimeInterval)duration animations:(void (^ __nullable)(void))animatons completion:(void (^ __nullable)(BOOL finished))completion;
@end
