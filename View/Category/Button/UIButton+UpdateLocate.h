//
//  UIButton+UpdateLocate.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/13.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  更新按钮的位置
 */
@interface UIButton (UpdateLocate)

/**
 *  按钮中的标题和图片水平对齐 且标题居左，图片居右
 *
 *  @param paramSpace 标题和图片之间的距离
 */
- (void)buttonContentAligeHorizonalTitle_ImageForSpace:(CGFloat)paramSpace;

@end
