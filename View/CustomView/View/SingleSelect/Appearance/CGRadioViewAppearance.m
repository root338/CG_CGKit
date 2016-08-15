//
//  CGRadioViewAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioViewAppearance.h"

@implementation CGRadioViewAppearance

- (void)setupLineBoxType:(LineBoxType)type color:(UIColor *)color width:(CGFloat)width
{
    self.lineBoxType    = type;
    self.lineColor      = color;
    self.lineLength     = width;
}

- (void)setupSliderViewBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius
{
    self.sliderViewBorderColor  = borderColor;
    self.sliderViewBorderWidth  = borderWidth;
    self.sliderViewCornerRadius = cornerRadius;
}

- (UIEdgeInsets)getSubviewEdgeInsets
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (self.lineBoxType & LineBoxTypeTop) {
        edgeInsets.top  = self.lineLength;
    }
    if (self.lineBoxType & LineBoxTypeLeft) {
        edgeInsets.left = self.lineLength;
    }
    if (self.lineBoxType & LineBoxTypeBottom) {
        edgeInsets.bottom   = self.lineLength;
    }
    if (self.lineBoxType & LineBoxTypeRight) {
        edgeInsets.right    = self.lineLength;
    }
    return edgeInsets;
}

- (CGFloat)getVerticalAllSpace
{
    UIEdgeInsets insets = [self getSubviewEdgeInsets];
    return insets.top + insets.bottom + self.marginEdgeInsets.top + self.marginEdgeInsets.bottom;
}

@end
