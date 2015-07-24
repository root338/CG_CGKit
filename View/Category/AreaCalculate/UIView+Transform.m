//
//  UIView+Transform.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/13.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+Transform.h"

@implementation UIView (Transform)

- (void)rorationWithAngle:(CGFloat)angle
{
    self.transform = CGAffineTransformMakeRotation(angle);
}

- (void)rorationWithAngle:(CGFloat)angle completion:(void (^)(BOOL))completion
{
    [self rorationWithAngle:angle duration:.3 completion:completion];
}

- (void)rorationWithAngle:(CGFloat)angle duration:(NSTimeInterval)duration completion:(void (^)(BOOL))completion
{
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformMakeRotation(angle);
    } completion:completion];
}
@end
