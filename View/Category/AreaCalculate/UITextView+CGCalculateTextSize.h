//
//  UITextView+CGCalculateTextSize.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGInputTextProtocol.h"

@interface UITextView (CGCalculateTextSize)<CGInputTextProtocol>

//- (CGSize)calculateLabelTextSize;
//
//- (CGRect)calculateMultilineLabelTextSizeWithMaxWidth:(CGFloat)maxWidth;
//- (CGRect)calculateMultilineLabelTextSizeWithMaxSize:(CGSize)maxSize;
//
///**
// *  根据内部文本的绘制区域计算文本框的大小
// *
// *  @param textRect 文本的绘制区域
// *
// *  @return 返回文本框的大小
// */
//- (CGSize)calculateLabelSizeWithTextRect:(CGRect)textRect;
//
///** 计算文本框的大小 （maxWidth：最大的宽度） */
//- (CGSize)calculateLabelSizeWithMaxWidth:(CGFloat)maxWidth;

@end
