//
//  UIButton+UpdateLocate.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/13.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGButtonAlignStyleHeader.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  更新按钮的位置
 */
@interface UIButton (UpdateLocate)

/**
 *  按钮中的标题和图片水平对齐 且标题居左，图片居右
 *
 *  @param paramSpace 标题和图片之间的距离
 */
- (void)buttonContentAligeHorizonalTitle_ImageForSpace:(CGFloat)paramSpace __deprecated_msg("请使用 - cg_calculateButtonSizeWithStyle: space:");

/** 根据标题与图片设置按钮的大小 paramSpace为两者之间的间距 */
- (CGSize)cg_updateButtonSizeWithStyle:(CGButtonStyle)style space:(CGFloat)paramSpace;

/** 根据标题与图片计算按钮最适合的大小 */
- (CGSize)cg_calculateButtonSizeWithStyle:(CGButtonStyle)style space:(CGFloat)paramSpace;

/**
 *  设置按钮的状态
 *
 *  @param style      对齐状态
 *  @param paramSpace 标题与图像的间距
 */
- (void)cg_updateButtonWithStyle:(CGButtonStyle)style space:(CGFloat)paramSpace;
@end
NS_ASSUME_NONNULL_END
