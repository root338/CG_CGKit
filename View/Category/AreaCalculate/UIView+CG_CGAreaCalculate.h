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
 *  计算 maxWith - (left + right)
 *
 *  @param size       视图大小
 *  @param edgeInsets 边距值
 *
 *  @return 返回计算后的宽度
 */
CGFloat CG_CGWidthWithMaxWidth(CGFloat maxWidth, UIEdgeInsets edgeInsets);

/**
 *  计算 left + width + right
 *
 *  @param width      宽度
 *  @param edgeInsets 边距
 *
 *  @return 返回计算后大小
 */
CGFloat CG_CGMaxWidthWithWidth(CGFloat width, UIEdgeInsets edgeInsets);

/**
 *  计算 maxHeight - (top + bottom)
 *
 *  @param size       视图大小
 *  @param edgeInsets 边距值
 *
 *  @return 返回计算后的高度
 */
CGFloat CG_CGHeightWithMaxHeight(CGFloat maxHeight, UIEdgeInsets edgeInsets);

/**
 *  计算 top + height + bottom
 *
 *  @param size       视图大小
 *  @param edgeInsets 边距值
 *
 *  @return 返回计算后的高度
 */
CGFloat CG_CGMaxHeightWithHeight(CGFloat height, UIEdgeInsets edgeInsets);

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
 *  计算 {width + left + right, height + top + bottom}
 *
 *  @param rect       指定子区域
 *  @param edgeInsets 边距大小
 *
 *  @return 返回CGRect
 */
CGRect CG_CGMaxBoundsWithRectMargin(CGRect rect, UIEdgeInsets edgeInsets);

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

/**
 *  根据CGPoint，CGSize设置CGRect
 *
 *  @param position CGPoint，坐标
 *  @param size     CGSize，大小
 *
 *  @return 返回CGRect值
 */
CGRect CG_CGRectWithMake(CGPoint position, CGSize size);
@end
