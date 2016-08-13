//
//  CGCycleScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGScrollViewDefineHeader.h"
#import "CGCycleScrollViewDefineHeader.h"
#import "CGCycleScrollViewProxyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class CGCycleScrollViewCell, CGCycleScrollAppearance;

/**
 *  循环滑动视图基类
 *  主要功能：可以设置滑动内容是否可以循环滑动
 *          只有在循环滑动下才可以设置是否自动滑动
 *          可以设置是否缓存已创建的视图
 *          可以设置子视图与子视图之间的间距
 *          可以设置横滑还是竖滑
 *
 *  优化：1.分离类；2.没有实现缓存重复视图（同样视图同时出现，比如循环滑动1，2张图时）；3.不分页条件下无法将最近的视图定位到中间（原因是三视图循环无法定位停止坐标（现在的思路主要是在将要停止时在移动到中间，不过这样动画起来太违和了，没有实现））
 */
@interface CGCycleScrollView : UIView

@property (nullable, weak, nonatomic) id<CGCycleScrollViewDataSource> dataSource;

@property (nullable, weak, nonatomic) id<CGCycleScrollViewDelegate> delegate;

@property (nonatomic, assign) CGScrollDirectionType scrollDirection;

@property (nullable, nonatomic, strong) CGCycleScrollAppearance *appearance;


/** 
 *  设置开始的cell索引并设置该cell的位置 
 *  @param 循环视图加载视图时需要一个标识的cell来确定滑动区域中显示哪些索引视图
 */
- (void)setupIndex:(NSInteger)index position:(CGCycleCellPosition)position;

/** 刷新视图 */
- (void)reloadAllView;

@end

NS_ASSUME_NONNULL_END