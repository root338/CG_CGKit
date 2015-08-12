//
//  UIButton+CreateCustomButton.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIButton+CGCreateCustomButton.h"

@implementation UIButton (CGCreateCustomButton)

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    UIButton *button = [self buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor radius:(CGFloat)radius
{
    UIButton *button = [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font];
    button.layer.borderColor    = [borderColor CGColor];
    button.layer.borderWidth    = borderWidth;
    button.layer.cornerRadius   = radius;
    button.layer.masksToBounds  = YES;
    
    return button;
}
@end
