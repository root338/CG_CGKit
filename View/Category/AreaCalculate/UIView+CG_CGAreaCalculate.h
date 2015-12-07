//
//  UIView+CG_CGAreaCalculate.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 计算 maxWith - (left + right) */
UIKIT_STATIC_INLINE CGFloat CG_CGWidthWithMaxWidth(CGFloat maxWidth, UIEdgeInsets edgeInsets)
{
    return maxWidth - (edgeInsets.left + edgeInsets.right);
}

/** 计算 left + width + right */
UIKIT_STATIC_INLINE CGFloat CG_CGMaxWidthWithWidth(CGFloat width, UIEdgeInsets edgeInsets)
{
    return edgeInsets.left + width + edgeInsets.right;
}

/** 计算 maxHeight - (top + bottom) */
UIKIT_STATIC_INLINE CGFloat CG_CGHeightWithMaxHeight(CGFloat maxHeight, UIEdgeInsets edgeInsets)
{
    return maxHeight - (edgeInsets.top + edgeInsets.bottom);
}

/** 计算 top + height + bottom */
UIKIT_STATIC_INLINE CGFloat CG_CGMaxHeightWithHeight(CGFloat height, UIEdgeInsets edgeInsets)
{
    return edgeInsets.top + height + edgeInsets.bottom;
}

/** 计算 { { left, top }, { width - (left + right), height - (top + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}

/** 计算 { { 0, 0 }, { width + (left + right), height + (top + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGMaxBoundsWithRectMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(0, 0, CG_CGMaxWidthWithWidth(CGRectGetWidth(rect), edgeInsets), CG_CGMaxHeightWithHeight(CGRectGetHeight(rect), edgeInsets));
}

/** 忽略顶部 计算 { { left, originY }, { width - (left + right), height - (originY + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeTop(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY)
{
    return CGRectMake(edgeInsets.left, originY, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), rect.size.height - (originY + edgeInsets.bottom));
}

/** 忽略底部 计算 { { left, top }, { width - (left + right), height} } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat height)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), height);
}

/** 忽略垂直 计算 { { left, originY }, { width - (left + right), height } } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeVertical(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY, CGFloat height)
{
    return CGRectMake(edgeInsets.left, originY, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), height);
}

/** 忽略右边 计算 { { left, top }, { width , height - (top + bottom) } } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeRight(CGRect rect, UIEdgeInsets edgeInsets, CGFloat width)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, width, CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}

/** 忽略左边 计算 { { originX, top }, { width - (originX + right), height - (top + bottom) } }  */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeLeft(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originX) {
    return CGRectMake(originX, edgeInsets.top, CGRectGetWidth(rect) - (originX + edgeInsets.right), CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}

/** 忽略水平 计算 { { originX, top }, { width , height - (top + bottom) } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithExcludeHorizontal(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originX, CGFloat width)
{
    return CGRectMake(originX, edgeInsets.top, width, CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}

/** 计算 { position, size } */
UIKIT_STATIC_INLINE CGRect CG_CGRectWithMake(CGPoint position, CGSize size)
{
    return CGRectMake(position.x, position.y, size.width, size.height);
}
