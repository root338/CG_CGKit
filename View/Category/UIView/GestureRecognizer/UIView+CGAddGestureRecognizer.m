//
//  UIView+CGAddGestureRecognizer.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGAddGestureRecognizer.h"

@implementation UIView (CGAddGestureRecognizer)

- (__kindof UIGestureRecognizer *)cg_addGestureRecognizerWithType:(CGGestureRecognizerType)type action:(SEL)action
{
    return [self cg_addGestureRecognizerWithType:type target:self action:action];
}

- (__kindof UIGestureRecognizer *)cg_addGestureRecognizerWithType:(CGGestureRecognizerType)type target:(id)target action:(SEL)action
{
    UIGestureRecognizer *gesture    = [self cg_createGestureRecognizerWithType:type target:target action:action];
    [self addGestureRecognizer:gesture];
    return gesture;
}

- (__kindof UIGestureRecognizer *)cg_createGestureRecognizerWithType:(CGGestureRecognizerType)type action:(SEL)action
{
    return [self cg_createGestureRecognizerWithType:type target:self action:action];
}

- (__kindof UIGestureRecognizer *)cg_createGestureRecognizerWithType:(CGGestureRecognizerType)type target:(id)target action:(SEL)action
{
    UIGestureRecognizer *gesture = nil;
    switch (type) {
        case CGGestureRecognizerTypePan:
            gesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
            break;
        case CGGestureRecognizerTypeLongPress:
            gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
            break;
        case CGGestureRecognizerTypePinch:
            gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
            break;
        case CGGestureRecognizerTypeRotation:
            gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:action];
            break;
        case CGGestureRecognizerTypeSwipe:
            gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
            break;
        case CGGestureRecognizerTypeTap:
            gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
            break;
        default:
            break;
    }
    return gesture;
}

@end
