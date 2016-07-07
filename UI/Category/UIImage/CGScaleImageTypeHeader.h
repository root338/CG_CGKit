//
//  CGScaleImageTypeHeader.h
//  QuickAskCommunity
//
//  Created by DY on 16/7/7.
//  Copyright © 2016年 ym. All rights reserved.
//

#ifndef CGScaleImageTypeHeader_h
#define CGScaleImageTypeHeader_h

/** 图片缩放后大小计算方式 */
typedef NS_ENUM(NSInteger, CGScaleImageType) {
    /** 按图片大小等比缩放 */
    CGScaleImageTypeSize,
    /** 按图片大小等比缩放，并忽略图片大小小于指定大小的情况，宽或高较小时都忽略 */
    CGScaleImageTypeSizeForIgnoreMinSize,
    /** 按图片宽度等比缩放 */
    CGScaleImageTypeWidth,
    /** 按图片宽度等比缩放，并忽略图片宽度小于指定宽度的情况 */
    CGScaleImageTypeWidthForIgnoreMinWidth,
    /** 按图片高度等比缩放 */
    CGScaleImageTypeHeight,
    /** 按图片高度等比缩放，并忽略图片宽度小于指定高度的情况 */
    CGScaleImageTypeHeightForIgnoreMinHeight,
};

#endif /* CGScaleImageTypeHeader_h */
