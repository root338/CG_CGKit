//
//  CGCalculateCGSize.h
//  QuickAskCommunity
//
//  Created by DY on 16/7/7.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGScaleImageTypeHeader.h"

/** 计算size，在指定大小targetSize下，按照特定的缩放方式CGScaleImageType，进行缩放后的大小 */
CGSize cg_calculateScaleSize(CGSize size, CGSize targetSize, CGScaleImageType scaleType);