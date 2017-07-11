//
//  UIImage+CGColor.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIImage+CGColor.h"

@implementation UIImage (CGColor)

+ (UIImage *)imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor size:CGSizeMake(10, 10)];
}

+ (UIImage *)imageWithTintColor:(UIColor *)tintColor size:(CGSize)size
{
    return [self imageWithTintColor:tintColor size:size capInset:UIEdgeInsetsZero];
}

+ (UIImage *)imageWithTintColor:(UIColor *)tintColor size:(CGSize)size capInset:(UIEdgeInsets)capInset
{
    if (!tintColor) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, tintColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, capInset)) {
        image = [image resizableImageWithCapInsets:capInset];
    }
    
    UIGraphicsEndImageContext();
    return image;
}
@end
