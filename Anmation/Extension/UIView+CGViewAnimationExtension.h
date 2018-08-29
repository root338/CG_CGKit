//
//  UIView+CGViewAnimationExtension.h
//  QuickAskCommunity
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewAnimationDefineHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGViewAnimationExtension)


/**
 进行弹簧效果的动画
 如果使用约束，需要自己设置相关约束的变化
 bug: 不支持已经设置 transform 属性的视图
 */
- (void)animateWithStyle:(CGViewAnimationStyle)style type:(CGOperateViewAnimationType)type anchorPoint:(CGPoint)anchorPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

- (void)animateWithStyle:(CGViewAnimationStyle)style type:(CGOperateViewAnimationType)type anchorPoint:(CGPoint)anchorPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
