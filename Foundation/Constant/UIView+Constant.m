//
//  NSObject+Constant.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+Constant.h"

#pragma mark - 常量数值
const CGFloat            CGZeroFloatValue   = 0.0001;

#pragma mark - 简单自动布局常量值
const UIViewAutoresizing    UIViewAutoresizingFlexibleAllMargin = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

const UIViewAutoresizing    UIViewAutoresizingFlexibleSize = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

@implementation UIView (CGValueConstant)

+ (CGFloat)onePixlesForCGKitUIScreenScale
{
    return 1.0 / MAX([UIScreen mainScreen].scale, 1);
}

@end
