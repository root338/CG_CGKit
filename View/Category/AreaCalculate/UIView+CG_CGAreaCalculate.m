//
//  UIView+CG_CGAreaCalculate.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+CG_CGAreaCalculate.h"

@implementation UIView (CG_CGAreaCalculate)

CGRect CGRectWithMargin(CGRect rect, UIEdgeInsets edgeInsets)
{
    return CGRectMake(edgeInsets.left, edgeInsets.top, rect.size.width - (edgeInsets.left + edgeInsets.right), rect.size.height - (edgeInsets.top + edgeInsets.bottom));
}

@end
