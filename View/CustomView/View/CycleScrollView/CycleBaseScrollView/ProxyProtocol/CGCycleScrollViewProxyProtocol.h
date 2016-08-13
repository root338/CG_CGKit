//
//  CGCycleScrollViewProxyProtocol.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGCycleScrollView, CGCycleScrollViewCell;

@protocol CGCycleScrollViewDataSource <NSObject>

/**
 *  设置滑动视图有多少个视图
 *
 *  @param cycleScrollView 当前循环滑动视图
 *
 *  @return 添加多少个子视图
 */
- (NSInteger)numberCycleScrollView:(CGCycleScrollView *)cycleScrollView;

/**
 *  设置每个自定义的滑动视图
 *
 *  @param cycleScrollView 当前循环滑动视图
 *  @param index           设置滑动视图的索引
 *
 *  @return 返回设置的当前的滑动视图
 */
- (__kindof CGCycleScrollViewCell *)cycleScrollView:(CGCycleScrollView *)cycleScrollView cellAtIndex:(NSInteger)index;

@optional
/**
 *  添加分页视图
 *  @warning 需要用户设置分页视图相对于滑动视图的坐标
 *
 *  @param cycleScrollView 当前循环滑动视图
 *
 *  @return 返回需要添加的分页视图
 */
- (UIView *)cycleScrollViewAddPageView:(CGCycleScrollView *)cycleScrollView;

@end


@protocol CGCycleScrollViewDelegate <NSObject>

@optional

/** 设置指定cell的大小 */
- (CGSize)cycleScrollView:(CGCycleScrollView *)cycleScrollView cellSizeAtIndex:(NSInteger)index;

/** cell的间距 */
- (CGFloat)cycleScrollView:(CGCycleScrollView *)cycleScrollView cellSpaceForAtIndex:(NSInteger)index;

/**
 *  设置cell的边长
 *  @param 当横向滑动时，该值表示宽度，高度和滑动视图相同
 *  @param 当纵向滑动时，该值表示高度，宽度和滑动视图相同
 *  @param 当实现代理方法cycleScrollView:sizeAtIndex:时，此方法被忽略
 */
- (CGFloat)cycleScrollView:(CGCycleScrollView *)cycleScrollView lenghtAtIndex:(NSInteger)index;

/** 设置加载cell的大小 */
//- (CGSize)cycleScrollView:(CGCycleScrollView *)cycleScrollView sizeAtIndex:(NSInteger)index;

/**
 *  设置cell坐标的显示位置
 *
 *  @param 当实现代理方法cycleScrollView:pointAtIndex:时，此方法被忽略
 */
//- (CGCycleCellPosition)cycleScrollView:(CGCycleScrollView *)cycleScrollView postitionAtIndex:(NSInteger)index;

/** 设置加载cell的坐标 */
//- (CGPoint)cycleScrollView:(CGCycleScrollView *)cycleScrollView pointAtIndex:(NSInteger)index;

/**
 *  已选择时的视图
 *
 *  @param cycleScrollView 当前循环滑动视图
 *  @param index           视图的索引
 */
- (void)cycleScrollView:(CGCycleScrollView *)cycleScrollView didSelectRowAtIndex:(NSInteger)index;

/**
 *  当前显示索引改变时回调
 *
 *  @param cycleScrollView 当前循环滑动视图
 *  @param currentIndex    当前显示索引
 */
- (void)cycleScrollView:(CGCycleScrollView *)cycleScrollView didChangeCurrentIndex:(NSInteger)currentIndex;
@end
