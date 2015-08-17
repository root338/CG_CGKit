//
//  NSObject+Constant.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSObject+Constant.h"

const UIViewAutoresizing UIViewAutoresizingFlexibleAllMargin = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;

const UIViewAutoresizing UIViewAutoresizingFlexibleSize = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

UIEdgeInsets UIEdgeInsetsMakeAllEqualValue(CGFloat value)
{
    return UIEdgeInsetsMake(value, value, value, value);
}