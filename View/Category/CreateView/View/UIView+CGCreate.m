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
    UIView *view = [self cg_createView];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}
@end
