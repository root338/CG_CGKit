//
//  UIButton+AreaCalculate.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/22.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  计算按钮一些常用值
 */
@interface UIButton (AreaCalculate)

/**
 *  计算按钮当前标题的大小
 *
 *  @return 返回计算后的大小
 */
- (CGSize)calculateButtonCurrentTitleSize;

@end
