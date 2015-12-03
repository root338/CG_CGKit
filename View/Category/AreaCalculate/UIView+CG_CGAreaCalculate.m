//
//  UIView+CG_CGAreaCalculate.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+CG_CGAreaCalculate.h"

@implementation UIView (CG_CGAreaCalculate)

CGFloat CG_CGWidthWithSize(CGSize size, UIEdgeInsets edgeInsets)
{
    return size.width - (edgeInsets.left + edgeInsets.right);
}

CGFloat CG_CGHeightWithSize(CGSize size, UIEdgeInsets edgeInsets)
{
    return size.height - (edgeInsets.top + edgeInsets.bottom);
}

CGRect CGRectWithMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithSize(rect.size, edgeInsets), CG_CGHeightWithSize(rect.size, edgeInsets));
}

CGRect CG_CGRectWithExcludeTop(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY)
{
    return CGRectMake(edgeInsets.left, originY, CG_CGWidthWithSize(rect.size, edgeInsets), rect.size.height - (originY + edgeInsets.bottom));
}

CGRect CG_CGRectWithExcludeBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat height)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, CG_CGWidthWithSize(rect.size, edgeInsets), height);
}

CGRect CG_CGRectWithExcludeTopBottom(CGRect rect, UIEdgeInsets edgeInsets, CGFloat originY, CGFloat height)
{
    return CGRectMake(edgeInsets.left, originY, CG_CGWidthWithSize(rect.size, edgeInsets), height);
}

CGRect CG_CGRectWithMake(CGPoint position, CGSize size)
{
    return CGRectMake(position.x, position.y, size.width, size.height);
}
@end
