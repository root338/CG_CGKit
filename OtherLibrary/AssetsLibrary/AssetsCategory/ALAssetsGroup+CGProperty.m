//
//  ALAssetsGroup+CGProperty.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ALAssetsGroup+CGProperty.h"

@implementation ALAssetsGroup (CGProperty)

- (NSString *)assetsGroupName
{
    return [self valueForProperty:ALAssetsGroupPropertyName];
}

- (UIImage *)posterAssetsGroupImage
{
    CGImageRef imageRef     = [self posterImage];
    UIImage *posterImage    = nil;
    
    if (imageRef) {
        posterImage     = [UIImage imageWithCGImage:imageRef];
    }
    
    return posterImage;
}

@end
