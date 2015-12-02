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
 *  计算size中距离左右边距最大的宽度
 *
 *  @param size       视图大小
 *  @param edgeInsets 边距值
 *
 *  @return 返回计算后的宽度
 */
CGFloat CG_CGWidthWithSize(CGSize size, UIEdgeInsets edgeInsets);

/**
 *  计算size中距离上下边距最大的高度
 *
 *  @param size       视图大小
 *  @param edgeInsets 边距值
 *
 *  @return 返回计算后的高度
 */
CGFloat CG_CGHeightWithSize(CGSize size, UIEdgeInsets edgeInsets);

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

/**
 *  计算区域类出去边界的区域（排除上边距）
 *  @warning 该rect应该为 UIView的相对区域，计算出的新坐标区域是相对于给定的rect的坐标系，由于排除上边距，所以y坐标需要自定义，再根据y坐标计算高度
 *
 *  @param rect       指定区域
 *  @param edgeInsets 边界大小
 *  @param originY    视图高度
 *
 *  @return 返回新的坐标
 */
CGRect CG_CGRectWithExcludeTop(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY);

/**
 *  计算区域类出去边界的区域（排除下边距）
 *  @warning 该rect应该为 UIView的相对区域，计算出的新坐标区域是相对于给定的rect的坐标系，由于排除下边距，所以高度需要自定义
 *
 *  @param rect       指定区域
 *  @param edgeInsets 边界大小
 *  @param height     视图高度
 *
 *  @return 返回新的坐标
 */
CGRect CG_CGRectWithExcludeBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat height);

/**
 *  计算区域类出去边界的区域（排除上下边距）
 *  @warning 该rect应该为 UIView的相对区域，计算出的新坐标区域是相对于给定的rect的坐标系，由于排除上下边距，所以y坐标和高度需要自定义
 *
 *  @param rect       制定视图区域
 *  @param edgeInsets 边界大小
 *  @param originY    y坐标
 *  @param height     视图高度
 *
 *  @return 返回新的坐标
 */
CGRect CG_CGRectWithExcludeTopBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY, CGFloat height);
@end
