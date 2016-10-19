//
//  UIView+CGCreate.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGCreate.h"

@implementation UIView (CGCreate)

+ (instancetype)cg_createView
{
    return [[self alloc] init];
}

+ (instancetype)cg_createClearColorView
{
    return [self cg_createViewWithBackgroundColor:[UIColor clearColor]];
}

+ (instancetype)cg_createViewWithBackgroundColor:(UIColor *)backgroundColor
{
    UIView *view            = [[self alloc] initWithFrame:CGRectZero];
    view.backgroundColor    = backgroundColor;
    return view;
}
@end
