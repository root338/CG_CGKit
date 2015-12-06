//
//  UIView+CG_CGAreaCalculate.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+CG_CGAreaCalculate.h"

@implementation UIView (CG_CGAreaCalculate)

CGFloat CG_CGWidthWithMaxWidth(CGFloat maxWidth, UIEdgeInsets edgeInsets)
{
    return maxWidth - (edgeInsets.left + edgeInsets.right);
}

CGFloat CG_CGMaxWidthWithWidth(CGFloat width, UIEdgeInsets edgeInsets)
{
    return edgeInsets.left + width + edgeInsets.right;
}

CGFloat CG_CGHeightWithMaxHeight(CGFloat maxHeight, UIEdgeInsets edgeInsets)
{
    return maxHeight - (edgeInsets.top + edgeInsets.bottom);
}

CGFloat CG_CGMaxHeightWithHeight(CGFloat height, UIEdgeInsets edgeInsets)
{
    return edgeInsets.top + height + edgeInsets.bottom;
}

CGRect CGRectWithMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), CG_CGHeightWithMaxHeight(CGRectGetHeight(rect), edgeInsets));
}

CGRect CG_CGMaxBoundsWithRectMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(0, 0, CG_CGMaxWidthWithWidth(CGRectGetWidth(rect), edgeInsets), CG_CGMaxHeightWithHeight(CGRectGetHeight(rect), edgeInsets));
}

CGRect CG_CGRectWithExcludeTop(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY)
{
    return CGRectMake(edgeInsets.left, originY, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), rect.size.height - (originY + edgeInsets.bottom));
}

CGRect CG_CGRectWithExcludeBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat height)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), height);
}

CGRect CG_CGRectWithExcludeTopBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY, CGFloat height)
{
    return CGRectMake(edgeInsets.left, originY, CG_CGWidthWithMaxWidth(CGRectGetWidth(rect), edgeInsets), height);
}

CGRect CG_CGRectWithMake(CGPoint position, CGSize size)
{
    return CGRectMake(position.x, position.y, size.width, size.height);
}
@end
