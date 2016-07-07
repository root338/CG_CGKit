//
//  UIImage+CGScaleImageSize.m
//  QuickAskCommunity
//
//  Created by DY on 16/5/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIImage+CGScaleImageSize.h"

#import "CGCalculateCGSize.h"

@implementation UIImage (CGScaleImageSize)

- (CGSize)cg_calculateImageScaleAspectFitSizeWithTargetSize:(CGSize)targetSize
{
    return [self cg_calculateImageScaleType:CGScaleImageTypeSize aspectFitSizeWithTargetSize:targetSize];
}

- (CGSize)cg_calculateImageScaleType:(CGScaleImageType)scaleType aspectFitSizeWithTargetSize:(CGSize)targetSize
{
    return cg_calculateScaleSize(self.size, targetSize, scaleType);
}

@end
