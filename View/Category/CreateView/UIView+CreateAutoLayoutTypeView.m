//
//  UIView+CreateAutoLayoutTypeView.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+CreateAutoLayoutTypeView.h"

@implementation UIView (CreateAutoLayoutTypeView)

+ (instancetype)newAutoLayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

@end
