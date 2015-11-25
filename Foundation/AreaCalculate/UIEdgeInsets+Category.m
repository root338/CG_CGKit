//
//  UIEdgeInsets+Category.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/25.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIEdgeInsets+Category.h"


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