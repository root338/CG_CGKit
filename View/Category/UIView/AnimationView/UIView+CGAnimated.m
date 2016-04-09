//
//  UIView+CGAnimated.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UIView+CGAnimated.h"

@implementation UIView (CGAnimated)

- (void)changeStatusWithIsAnimated:(BOOL)isAnimated animations:(void (^)(void))animatons
{
    [self changeStatusWithIsAnimated:isAnimated duration:0.3 animations:animatons];
}

- (void)changeStatusWithIsAnimated:(BOOL)isAnimated duration:(NSTimeInterval)duration animations:(void (^)(void))animatons
{
    [self changeStatusWithIsAnimated:isAnimated duration:duration animations:animatons completion:nil];
}

- (void)changeStatusWithIsAnimated:(BOOL)isAnimated duration:(NSTimeInterval)duration animations:(void (^)(void))animatons completion:(void (^)(BOOL))completion
{
    if (isAnimated) {
        [UIView animateWithDuration:duration animations:animatons completion:completion];
    }else {
        if (animatons) {
            animatons();
        }
    }
}

@end
