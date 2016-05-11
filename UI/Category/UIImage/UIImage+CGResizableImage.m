//
//  UIImage+CGResizableImage.m
//  QuickAskCommunity
//
//  Created by DY on 16/5/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIImage+CGResizableImage.h"

@implementation UIImage (CGResizableImage)

+ (UIImage *)cg_resizableImageWithCapCenterImageName:(NSString *)imageName
{
    
    UIImage *image  = [UIImage imageNamed:imageName];
    
    CGSize imageSize        = image.size;
    CGFloat horizontalSpace = imageSize.width / 2.0 - 1;
    CGFloat verticalSpace   = imageSize.height / 2.0 - 1;
    
    image   = [image resizableImageWithCapInsets:UIEdgeInsetsMake(horizontalSpace, verticalSpace, horizontalSpace, verticalSpace)];
    
    return image;
}

@end
