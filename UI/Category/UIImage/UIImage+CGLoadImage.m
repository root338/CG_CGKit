//
//  UIImage+CGLoadImage.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/22.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIImage+CGLoadImage.h"

@implementation UIImage (CGLoadImage)

+ (NSString *)cg_getImagePathWithImageName:(NSString *)imageName withExtension:(NSString *)ext
{
    return [[NSBundle mainBundle] pathForResource:imageName ofType:ext];
}

+ (NSString *)cg_getPNGImagePathWithImageName:(NSString *)imageName
{
    return [self cg_getImagePathWithImageName:imageName withExtension:@"png"];
}

+ (UIImage *)cg_loadPNGImageName:(NSString *)imageName
{
    return [self cg_loadImageName:imageName withExtension:@"png"];
}

+ (UIImage *)cg_loadImageName:(NSString *)imageName withExtension:(NSString *)ext
{
    if (!imageName.length || !ext.length) {
        return nil;
    }
    return [UIImage imageWithContentsOfFile:[self cg_getImagePathWithImageName:imageName withExtension:ext]];
}

+ (UIImage *)cg_imageName:(NSString *)imageName
{
    if (!imageName) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    image   = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
