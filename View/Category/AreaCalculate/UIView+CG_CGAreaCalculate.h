//
//  UIView+CG_CGAreaCalculate.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 坐标区域计算 */
@interface UIView (CG_CGAreaCalculate)

/**
 *  计算区域类出去边界的区域
 *  @warning 该rect应该为 UIView的相对区域，计算出的新坐标区域是相对于给定的rect的坐标系
 *
 *  @param rect       指定区域
 *  @param edgeInsets 边界大小
 *
 *  @return 返回新的坐标
 */
CGRect CGRectWithMargin(CGRect rect, UIEdgeInsets edgeInsets);

@end
