//
//  UIScrollView+CGPullToRefresh.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/26.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CGPullToRefresh)

/**
 *  添加下拉刷新视图
 *
 *  @param target   目标
 *  @param selector 当刷新时触发的方法
 */
- (void)addHeaderRefreshViewWithTarget:(id)target selector:(SEL)selector;

/**
 *  添加上拉刷新视图
 *
 *  @param target   目标
 *  @param selector 当刷新时触发的方法
 */
- (void)addFooterRefreshViewWithTarget:(id)target selector:(SEL)selector;
@end
