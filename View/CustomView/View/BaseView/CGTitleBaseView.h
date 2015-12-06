//
//  CGSingleTitleBaseView.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseView.h"

@class CGTitleBaseView;
@protocol CGTitleBaseViewDataSource <NSObject>

@optional
/**
 *  是否执行layoutSubviews方法的重置布局
 *
 *  @param titleView 标题视图
 *
 *  @return 返回一个BOOL值
 */
- (BOOL)shouldLayoutSubviewsTitleView:(CGTitleBaseView *)titleView;

@end

/** 标题视图基类 */
@interface CGTitleBaseView : CGBaseView

@property (weak, nonatomic) id<CGTitleBaseViewDataSource> delegate;

/** 标题距离视图四周的距离 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsets;



/** 单标题视图的弱引用 */
@property (weak, nonatomic) UIView *singleTitleView;

@end
