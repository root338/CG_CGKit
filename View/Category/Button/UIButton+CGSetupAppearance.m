//
//  UIButton+SetupAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIButton+CGSetupAppearance.h"

#import "UIImage+CGLoadImage.h"

@implementation UIButton (CGSetupAppearance)

- (void)setImageName:(NSString *)localImageName forState:(UIControlState)state
{
    [self setImageName:localImageName forState:state renderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)setImageName:(NSString *)localImageName forState:(UIControlState)state renderingMode:(UIImageRenderingMode)renderingMode
{
    UIImage *image = nil;
    if (localImageName) {
        image   = [UIImage imageNamed:localImageName];
        image   = [image imageWithRenderingMode:renderingMode];
    }
    
    [self setImage:image forState:state];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor forState:(UIControlState)state
{
    [self setTitle:title forState:state];
    [self setTitleColor:titleColor forState:state];
}

- (void)cg_setupTitles:(NSDictionary<NSNumber *,NSString *> *)titles
{
    [titles enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [self setTitle:obj forState:key.integerValue];
    }];
}

- (void)cg_setupTitleColors:(NSDictionary<NSNumber *,UIColor *> *)titleColors
{
    [titleColors enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIColor * _Nonnull obj, BOOL * _Nonnull stop) {
        [self setTitleColor:obj forState:key.integerValue];
    }];
}

- (void)cg_setupImages:(NSDictionary<NSNumber *,UIImage *> *)images
{
    [images enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        [self setImage:obj forState:key.integerValue];
    }];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(UIImage *)image forState:(UIControlState)state
{
    [self cg_setupWithTitle:title titleColor:titleColor forState:state];
    [self setImage:image forState:state];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    [self setTitle:title forState:UIControlStateNormal];
    !titleColor ?: [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    !font ?: [self.titleLabel setFont:font];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font normalImageName:(NSString *)normalImageName
{
    [self cg_setupWithTitle:title titleColor:titleColor font:font];
    [self cg_setupWithNormalImageName:normalImageName selectImageName:nil];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font defalutNormalImageName:(NSString *)normalImageName
{
    [self cg_setupWithTitle:title titleColor:titleColor font:font];
    [self cg_setupWithDefalutNormalImageName:normalImageName selectImageName:nil];
}

- (void)cg_setupWithNormalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    UIImage *normalImage = normalImageName == nil ? nil : [UIImage cg_imageName:normalImageName];
    !normalImage ?: [self setImage:normalImage forState:UIControlStateNormal];
    
    UIImage *selectImage = selectImageName == nil ? nil : [UIImage cg_imageName:selectImageName];
    !selectImage ?: [self setImage:selectImage forState:UIControlStateSelected];
}

- (void)cg_setupWithDefalutNormalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    !normalImage ?: [self setImage:normalImage forState:UIControlStateNormal];
    
    UIImage *selectImage = [UIImage imageNamed:selectImageName];
    !selectImage ?: [self setImage:selectImage forState:UIControlStateSelected];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font radius:(CGFloat)radius
{
    [self cg_setupWithTitle:title titleColor:titleColor font:font];
    [self cg_setupBorderWithCornerRadius:radius];
}

- (void)cg_setupWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor radius:(CGFloat)radius
{
    [self cg_setupWithTitle:title titleColor:titleColor font:font];
    [self cg_setupBorderWithWidth:borderWidth color:borderColor cornerRadius:radius];
}
@end
