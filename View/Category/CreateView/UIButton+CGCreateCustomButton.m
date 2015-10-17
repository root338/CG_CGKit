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

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font radius:(CGFloat)radius
{
    return [self cg_createButtonWithButtonType:type
                                         title:title
                                    titleColor:titleColor
                                          font:font
                                   borderWidth:0
                                   borderColor:0
                                        radius:radius];
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

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    UIImage *normalImage = [self loadLocalImageName:normalImageName];
    UIImage *selectImage = [self loadLocalImageName:selectImageName];
    
    UIButton *button = [self buttonWithType:type];
    !normalImage ?: [button setImage:normalImage forState:UIControlStateNormal];
    !selectImage ?: [button setImage:selectImage forState:UIControlStateSelected];
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName space:(CGFloat)space
{
    UIImage *image = [self loadLocalImageName:normalImageName];
    return [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font normalImage:image space:space];
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage space:(CGFloat)space
{
    UIButton *button = [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font];
    !normalImage ?: [button setImage:normalImage forState:UIControlStateNormal];
    
    if (space) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space);
    }
    
    return button;
}

+ (UIImage *)loadLocalImageName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
