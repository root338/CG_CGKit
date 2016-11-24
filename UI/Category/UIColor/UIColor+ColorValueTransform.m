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
    CGFloat alpha   = 0;
    if (valueType <= 0xFFFFFF) {
        alpha   = 1;
    }else {
        alpha   = ((valueType & 0xFF000000) >> 24) / 255.0;
    }
    return [self colorWithValueType:valueType alpha:alpha];
}

+ (UIColor *)colorWithValueType:(KCG_16_ColorValueType)valueType alpha:(CGFloat)alpha
{
    CGFloat red     = ((valueType & 0x00FF0000) >> 16) / 255.0;
    CGFloat green   = ((valueType & 0x0000FF00) >> 8) / 255.0;
    CGFloat blue    = (valueType & 0x000000FF) / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
