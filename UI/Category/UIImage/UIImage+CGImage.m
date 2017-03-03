//
//  UIImage+CGImage.m
//  QuickAskCommunity
//
//  Created by DY on 2017/2/27.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UIImage+CGImage.h"

@implementation UIImage (CGImage)

+ (instancetype)imageNamed:(NSString *)imageName renderingMode:(UIImageRenderingMode)renderingMode
{
    UIImage *image  = [UIImage imageNamed:imageName];
    if (image == nil) {
        return nil;
    }
    return [image imageWithRenderingMode:renderingMode];
}

+ (instancetype)imageNamed:(NSString *)imageName capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    UIImage *image  = [UIImage imageNamed:imageName];
    if (image == nil) {
        return image;
    }
    return [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
}

@end
