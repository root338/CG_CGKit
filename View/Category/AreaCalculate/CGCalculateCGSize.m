//
//  CGCalculateCGSize.m
//  QuickAskCommunity
//
//  Created by DY on 16/7/7.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGCalculateCGSize.h"

#import "CGPrintLogHeader.h"

CGSize cg_imageWidthScale(CGSize size, CGSize targetSize, CGFloat widthScale)
{
    return CGSizeMake(targetSize.width, size.height / widthScale);
}

CGSize cg_imageHeightScale(CGSize size, CGSize targetSize, CGFloat heightScale)
{
    return CGSizeMake(size.width / heightScale, targetSize.height);
}

CGSize cg_calculateScaleSize(CGSize size, CGSize targetSize, CGScaleImageType scaleType)
{
    CGFloat minScaleValue   = 0.001;
    if ((scaleType != CGScaleImageTypeHeight || scaleType != CGScaleImageTypeHeightForIgnoreMinHeight) && targetSize.width <= minScaleValue) {
        CGErrorLog(@"需要用到的指定宽度不能小于等于 0");
        return size;
    }
    if ((scaleType != CGScaleImageTypeWidth || scaleType != CGScaleImageTypeWidthForIgnoreMinWidth) && targetSize.height <= minScaleValue) {
        CGErrorLog(@"需要用到的指定高度不能小于等于 0");
        return size;
    }
    
    //宽度小于指定宽度
    BOOL isWidthLessThan    = size.width <= targetSize.width;
    //高度小于指定高度
    BOOL isHeightLessThan   = size.height <= targetSize.height;
    
    if (isWidthLessThan || isHeightLessThan) {
        if (scaleType == CGScaleImageTypeSizeForIgnoreMinSize) {
            //忽略较小大小时
            return size;
        }
        if (isWidthLessThan && scaleType == CGScaleImageTypeWidthForIgnoreMinWidth) {
            //忽略较小宽度时
            return size;
        }
        if (isHeightLessThan && scaleType == CGScaleImageTypeHeightForIgnoreMinHeight) {
            //忽略较小高度时
            return size;
        }
    }
    
    CGFloat widthScale  = size.width   / MAX(targetSize.width, minScaleValue);
    CGFloat heightScale = size.height  / MAX(targetSize.height, minScaleValue);
    
    CGSize  aspectFitSize           = CGSizeZero;
    
    if (scaleType == CGScaleImageTypeSize || scaleType == CGScaleImageTypeSizeForIgnoreMinSize) {
        //当根据等比宽度进行缩放时判断宽高更适合的进行缩放
        if (widthScale < heightScale) {
            
            aspectFitSize   = cg_imageHeightScale(size, targetSize, heightScale);
        }else {
            
            aspectFitSize   = cg_imageWidthScale(size, targetSize, widthScale);
        }
    }else if (scaleType == CGScaleImageTypeWidth || scaleType == CGScaleImageTypeWidthForIgnoreMinWidth) {
        
        aspectFitSize   = cg_imageWidthScale(size, targetSize, widthScale);
    }else if (scaleType == CGScaleImageTypeHeight || scaleType == CGScaleImageTypeHeightForIgnoreMinHeight) {
        
        aspectFitSize   = cg_imageHeightScale(size, targetSize, heightScale);
    }else if (scaleType == CGScaleImageTypeSizeForScaleAspectFill) {
        
        //当根据等比宽度进行缩放时判断宽高更适合的进行缩放
        if (widthScale < heightScale) {
            
            aspectFitSize   = cg_imageWidthScale(size, targetSize, widthScale);
        }else {
            
            aspectFitSize   = cg_imageHeightScale(size, targetSize, heightScale);
        }
    }else {
        
        CGErrorLog(@"设置的CGScaleImageType类型值不存在");
        aspectFitSize   = size;
    }
    
    return aspectFitSize;
}
