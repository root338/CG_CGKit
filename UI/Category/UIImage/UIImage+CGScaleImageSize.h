//
//  UIImage+CGScaleImageSize.h
//  QuickAskCommunity
//
//  Created by DY on 16/5/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGScaleImageTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 计算UIImage的大小 */

@interface UIImage (CGScaleImageSize)

/** 计算指定大小中图片等比例缩放大小 */
- (CGSize)cg_calculateImageScaleAspectFitSizeWithTargetSize:(CGSize)targetSize;

/** 计算指定缩放方式下的图片大小 */
- (CGSize)cg_calculateImageScaleType:(CGScaleImageType)scaleType aspectFitSizeWithTargetSize:(CGSize)targetSize;
@end

NS_ASSUME_NONNULL_END