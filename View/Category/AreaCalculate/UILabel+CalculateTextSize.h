//
//  UILabel+CalculateTextSize.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/29.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CalculateTextSize)

- (CGSize)calculateLabelTextSize;

- (CGRect)calculateMultilineLabelTextSizeWithMaxWidth:(CGFloat)maxWidth;
- (CGRect)calculateMultilineLabelTextSizeWithMaxSize:(CGSize)maxSize;

/**
 *  根据内部文本的绘制区域计算文本框的大小
 *
 *  @param textRect 文本的绘制区域
 *
 *  @return 返回文本框的大小
 */
- (CGSize)calculateLabelSizeWithTextRect:(CGRect)textRect;

/** 计算文本框的大小 （maxWidth：最大的宽度） */
- (CGSize)calculateLabelSizeWithMaxWidth:(CGFloat)maxWidth;
@end
