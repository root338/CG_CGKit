//
//  CGArrowIconConfig.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGArrowIconConfig.h"
#import "CGPrintLogHeader.h"

@implementation CGArrowIconConfig

+ (instancetype)defaultArrowConfig
{
    return [[CGArrowIconConfig alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        _arrowVertexOrientation = CGOrientationTypeLeft;
        _arrowVertex            = CGPointZero;
        _angle                  = 0;
        _arrowVertexOffset      = 0;
        _LeftVertex             = CGPointZero;
        _rightVertex            = CGPointZero;
    }
    return self;
}

- (void)setAngle:(CGFloat)angle
{
    if (angle > 1 && angle < 180) {
        _angle  = angle;
    }
    
    CGErrorConditionLog(angle <= 1 || angle >= 180, @"角度应该在(1, 180)开区间之内");
}
@end
