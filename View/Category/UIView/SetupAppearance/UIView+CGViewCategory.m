//
//  UIView+CGViewCategory.m
//  QuickAskCommunity
//
//  Created by DY on 2017/6/16.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UIView+CGViewCategory.h"

@implementation UIView (CGViewCategory)

- (CGPoint)cg_convertPoint:(CGPoint)point toView:(nullable UIView *)view
{
    return [self convertPoint:point toView:view];
}
- (CGPoint)cg_convertPoint:(CGPoint)point fromView:(nullable UIView *)view
{
    return [self convertPoint:point fromView:view];
}

- (CGRect)cg_convertRect:(CGRect)rect toView:(nullable UIView *)view
{
    return [self convertRect:rect toView:view];
}

- (CGRect)cg_convertRect:(CGRect)rect fromView:(nullable UIView *)view
{
    return [self convertRect:rect fromView:view];
}

@end
