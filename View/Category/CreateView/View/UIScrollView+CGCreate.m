//
//  UIScrollView+CGCreate.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIScrollView+CGCreate.h"

#import "UIScrollView+CGSetupAppearance.h"

@implementation UIScrollView (CGCreate)

+ (instancetype)cg_createWithScrollViewWithShowScrollIndicator:(BOOL)showScrollIndicator
{
    return [self cg_createWithScrollViewWithShowScrollIndicator:showScrollIndicator pagingEnabled:NO];
}

+ (instancetype)cg_createWithScrollViewWithShowScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled
{
    return [self cg_createWithScrollViewWithFrame:CGRectZero showScrollIndicator:showScrollIndicator pagingEnabled:paramPagingEnabled];
}

+ (instancetype)cg_createWithScrollViewWithFrame:(CGRect)frame showScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled
{
    UIScrollView *scrollView = [self cg_createView];
    [scrollView cg_setupWithFrame:frame showScrollIndicator:showScrollIndicator pagingEnabled:paramPagingEnabled];
    return scrollView;
}

@end
