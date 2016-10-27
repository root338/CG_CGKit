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
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _configType             = CGArrowIconConfigTypeNone;
        _angle                  = 90;
        _arrowVertex            = CGPointZero;
        _LeftVertex             = CGPointZero;
        _rightVertex            = CGPointZero;
        
        _arrowVertexOrientationType = CGOrientationTypeLeft;
    }
    return self;
}

- (void)setAngle:(CGFloat)angle
{
    if (angle > 1 && angle <= 180) {
        _angle  = angle;
    }
    
    CGErrorConditionLog(angle <= 1 || angle > 180, @"角度应该在(1, 180)开区间之内");
}
@end
