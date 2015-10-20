//
//  NSObject+Constant.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSObject+Constant.h"

#pragma mark - 简单自动布局常量值
const UIViewAutoresizing UIViewAutoresizingFlexibleAllMargin = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

const UIViewAutoresizing UIViewAutoresizingFlexibleSize = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

#pragma mark - UIEdgeInsets 相关设置函数
UIEdgeInsets UIEdgeInsetsMakeAllEqualValue(CGFloat value)
{
    return UIEdgeInsetsMake(value, value, value, value);
}

UIEdgeInsets UIEdgeInsetsZeroMakeExcludeTop(CGFloat topValue)
{
    return UIEdgeInsetsMake(topValue, 0, 0, 0);
}

UIEdgeInsets UIEdgeInsetsZeroMakeExcludeLeft(CGFloat leftValue)
{
    return UIEdgeInsetsMake(0, leftValue, 0, 0);
}

UIEdgeInsets UIEdgeInsetsZeroMakeExcludeBottom(CGFloat bottomValue)
{
    return UIEdgeInsetsMake(0, 0, bottomValue, 0);
}

UIEdgeInsets UIEdgeInsetsZeroMakeExcludeRight(CGFloat rightValue)
{
    return UIEdgeInsetsMake(0, 0, 0, rightValue);
}