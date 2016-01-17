//
//  UIButton+CreateCustomButton.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIButton+CGCreateCustomButton.h"

#import "UIView+CGSetupFrame.h"
#import "UIButton+UpdateLocate.h"
#import "UIView+CGSetupAppearance.h"

@implementation UIButton (CGCreateCustomButton)

+ (instancetype)cg_createDefaultButton
{
    return [UIButton buttonWithType:UIButtonTypeSystem];
}

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
    [button cg_setupBorderWithWidth:borderWidth color:borderColor cornerRadius:radius];
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    
    UIImage *normalImage = !normalImageName ? nil : [self loadLocalImageName:normalImageName];
    UIImage *selectImage = !selectImageName ? nil : [self loadLocalImageName:selectImageName];
    
    UIButton *button = [self buttonWithType:type];
    !normalImage ?: [button setImage:normalImage forState:UIControlStateNormal];
    !selectImage ?: [button setImage:selectImage forState:UIControlStateSelected];
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImage:(UIImage *)normalImage
{
    UIButton *button = [self buttonWithType:type];
    if (normalImage) {
        
        [button setImage:normalImage forState:UIControlStateNormal];
        
        CGRect frame = button.frame;
        if (CGRectEqualToRect(frame, CGRectZero)) {
            frame.size = normalImage.size;
            button.frame = frame;
        }
    }
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type normalImageName:(NSString *)normalImageName
{
    UIImage *normalImage = !normalImageName ? nil : [self loadLocalImageName:normalImageName];
    UIButton *button = [self cg_createButtonWithButtonType:type normalImage:normalImage];
    
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName
{
    UIImage *normalImage = !normalImageName ? nil : [self loadLocalImageName:normalImageName];
    return [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font normalImage:normalImage];
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage
{
    UIButton *button = [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font];
    !normalImage ?: [button setImage:normalImage forState:UIControlStateNormal];
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName space:(CGFloat)space
{
    UIImage *image = !normalImageName ? nil :[self loadLocalImageName:normalImageName];
    return [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font normalImage:image space:space];
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage space:(CGFloat)space
{
    UIButton *button = [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font normalImage:normalImage];
    
    if (space) {
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, space);
    }
    
    return button;
}

+ (instancetype)cg_createButtonAutoSizeWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage alignStyle:(CGButtonStyle)style space:(CGFloat)space
{
    UIButton *button = [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font normalImage:normalImage];
    
//    CGSize paramSize = [button cg_updateButtonSizeWithStyle:style space:space];
//    
//    if (style == CGButtonStyleHorizonalLeft || style == CGButtonStyleHorizonalRight) {
//        
//        button.size = paramSize;
//    }else {
//        
//        button.height   = paramSize.height;
//    }
//    
//    [button setNeedsLayout];
//    [button layoutIfNeeded];
//    
//    [button cg_updateButtonWithStyle:style space:space];
    [button sizeToFit];
    
    return button;
}

+ (instancetype)cg_createButtonWithButtonType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImage:(UIImage *)normalImage alignStyle:(CGButtonStyle)style space:(CGFloat)space size:(CGSize)paramSize
{
    UIButton *button    = [self cg_createButtonWithButtonType:type title:title titleColor:titleColor font:font normalImage:normalImage];
    button.size         = paramSize;
    [button cg_updateButtonWithStyle:style space:space];
    return button;
}

+ (UIImage *)loadLocalImageName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
