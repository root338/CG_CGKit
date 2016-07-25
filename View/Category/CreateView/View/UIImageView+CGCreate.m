//
//  UIImageView+CGCreate.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/24.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImageView+CGCreate.h"

@implementation UIImageView (CGCreate)

+ (UIImageView *)cg_createImageName:(NSString *)imageName
{
    return [self cg_createImageName:imageName contentMode:UIViewContentModeScaleAspectFill];
}

+ (UIImageView *)cg_createImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode
{
    return [self cg_createImageName:imageName contentMode:contentMode capInsets:UIEdgeInsetsZero];
}

+ (UIImageView *)cg_createImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode capInsets:(UIEdgeInsets)capInsets
{
    return [self cg_createImageName:imageName contentMode:contentMode capInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

+ (UIImageView *)cg_createImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode capInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!UIEdgeInsetsEqualToEdgeInsets(capInsets, UIEdgeInsetsZero)) {
        [image resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    }
    UIImageView *imageView = [[self alloc] initWithImage:image];
    imageView.contentMode   = contentMode;
    return imageView;
}

@end
