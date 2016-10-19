//
//  UIColor+ColorValueTransform.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/1.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIColor+ColorValueTransform.h"

@implementation UIColor (ColorValueTransform)

+ (UIColor *)colorWithValueType:(KCG_16_ColorValueType)valueType
{
    
    return [self colorWithValueType:valueType alpha:1];
}

+ (UIColor *)colorWithValueType:(KCG_16_ColorValueType)valueType alpha:(CGFloat)alpha
{
    CGFloat red     = ((valueType & 0X00FF0000) >> 16) / 255.0;
    CGFloat green   = ((valueType & 0X0000FF00) >> 8) / 255.0;
    CGFloat blue    = (valueType & 0X000000FF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
