//
//  UIImage+CGScaleImageSize.m
//  QuickAskCommunity
//
//  Created by DY on 16/5/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIImage+CGScaleImageSize.h"

#import "CGPrintLogHeader.h"

@implementation UIImage (CGScaleImageSize)

- (CGSize)cg_calculateImageScaleAspectFitSizeWithTargetSize:(CGSize)targetSize
{
    CGDebugAssert(targetSize.width > 0 && targetSize.height > 0, @"目标区域大小必须大于0");
    CGFloat widthScale  = self.size.width   / targetSize.width;
    CGFloat heightScale = self.size.height  / targetSize.height;
    
    CGFloat aspectFitSizeForWidth   = 0;
    CGFloat aspectFitSizeForHeight  = 0;
    
    if (widthScale < heightScale) {
        
        aspectFitSizeForWidth   = self.size.width   / heightScale;
        aspectFitSizeForHeight  = targetSize.height;
    }else {
        aspectFitSizeForWidth   = targetSize.width;
        aspectFitSizeForHeight  = self.size.height  / widthScale;
    }
    
    return CGSizeMake(aspectFitSizeForWidth, aspectFitSizeForHeight);
}

@end
