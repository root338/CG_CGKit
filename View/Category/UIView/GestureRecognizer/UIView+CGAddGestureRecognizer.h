//
//  UIView+CGAddGestureRecognizer.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 手势识别器的类型 */
typedef NS_ENUM(NSInteger, CGGestureRecognizerType){
    
    CGGestureRecognizerTypeTap,
    CGGestureRecognizerTypePan,
    CGGestureRecognizerTypeLongPress,
    CGGestureRecognizerTypeSwipe,
    CGGestureRecognizerTypePinch,
    CGGestureRecognizerTypeRotation,
};


/** 添加手势识别器 */
@interface UIView (CGAddGestureRecognizer)

/** 添加手势识别器(手势类型，处理方法) */
- (__kindof UIGestureRecognizer *)cg_addGestureRecognizerWithType:(CGGestureRecognizerType)type action:(SEL)action;

/** 添加手势识别器(手势类型，目标，处理方法) */
- (__kindof UIGestureRecognizer *)cg_addGestureRecognizerWithType:(CGGestureRecognizerType)type target:(id)target action:(SEL)action;

/** 创建手势识别器(手势类型，处理方法) */
- (__kindof UIGestureRecognizer *)cg_createGestureRecognizerWithType:(CGGestureRecognizerType)type action:(SEL)action;

/** 创建手势识别器(手势类型，目标，处理方法) */
- (__kindof UIGestureRecognizer *)cg_createGestureRecognizerWithType:(CGGestureRecognizerType)type target:(id)target action:(SEL)action;

@end
NS_ASSUME_NONNULL_END