//
//  CGBorderObject.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBorderObject.h"

@implementation CGBorderObject

+ (instancetype)cg_createBorderWithColorValue:(KCG_16_ColorValueType)color width:(CGFloat)width
{
    return [self cg_createBorderWithColorObject:[UIColor colorWithValueType:color] width:width];
}

+ (instancetype)cg_createBorderWithColorObject:(UIColor *)color width:(CGFloat)width
{

//    CGErrorConditionLog(!color,     @"设置的颜色为空");
//    CGErrorConditionLog(width <= 0, @"设置的边框应不小于0");
    
    CGBorderObject *borderObject = [[self alloc] initWithColor:color width:width];
    return borderObject;
}

- (instancetype)initWithColor:(UIColor *)color width:(CGFloat)width
{
    self = [super init];
    if (self) {
        _borderColor    = color;
        _borderWidth    = width;
    }
    return self;
}
@end
