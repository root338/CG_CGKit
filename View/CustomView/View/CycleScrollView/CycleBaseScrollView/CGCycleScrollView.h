//
//  CGCycleScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGScrollViewDefineHeader.h"

@class CGCycleScrollView;

/**
 *  循环滑动视图的滑动方向
 */
typedef NS_ENUM(NSInteger, CGCycleViewScrollDirection) {
    /**
     *  水平滑动
     */
    CGCycleViewScrollDirectionHorizontal,
    /**
     *  垂直滑动
     */
    CGCycleViewScrollDirectionVertical,
};

/** 滑动时视图根据滑动时的样式变化 */
typedef NS_ENUM(NSInteger, CGCycleViewScrollAnimationStyle) {
    
    CGCycleViewScrollAnimationStyleNone,
    CGCycleViewScrollAnimationStyleAnimation1,
};

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
- (UIView *)cycleScrollView:(CGCycleScrollView *)cycleScrollView viewAtIndex:(NSInteger)index;

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

#pragma mark - 只读
/** 加载的视图总数 */
@property (assign, nonatomic, readonly) NSInteger totalViewNumber;

#pragma mark - 代理
/**
 添加数据代理
 */


@property (weak, nonatomic) id<CGCycleScrollViewDataSource> dataSource;

@property (weak, nonatomic) id<CGCycleScrollViewDelegate> delegate;

#pragma mark - 滑动设置
/**
 是否循环滑动视图 默认为YES
 */
@property (assign, nonatomic) BOOL isCycle;

//暂时不进行设置，取消该属性定义后需要在getViewIndexForType:方法下添加相应条件，现在就以这种方式实现
///** 当不循环滑动时当前索引大于最大索引时重置索引等于最大索引 */
//@property (assign, nonatomic) BOOL isGreaterThanMaxIndexResetForNotCycle;
//
///** 当不循环滑动时当前索引小于最小索引时重置索引等于最小索引 */
//@property (assign, nonatomic) BOOL isLessThanMinIndexResetForNotCycle;

/**
 是否自动滑动，默认为NO
 当设值为YES时，delayTimeInterval属性为 2
 */
@property (assign, nonatomic) BOOL isAutoScrollView;

/**
 每隔多少秒滑动一次
 必须设置isAutoScrollView为YES，才能启动自动滑动
 */
@property (assign, nonatomic) NSTimeInterval delayTimeInterval;

/** 滑动时，子视图的显示样式 */
@property (nonatomic, assign) CGCycleViewScrollAnimationStyle animationStyle;

#pragma mark - 内容设置
/**
 *  当前显示视图的索引 
 *  @warning 在不分页或滑动时获取将不准确，建议使用cycleScrollView:didSelectRowAtIndex:方法获取
 */
@property (nonatomic, assign) NSInteger currentIndex;

///滑动视图相对父视图的四周边距
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsetForScrollView;

///滑动视图内部子视图内容的四周边距
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsetForSubviews;

/** 设置单个内容视图之间的间距 */
@property (assign, nonatomic) CGFloat subviewSpace;

/** 
 *  是否分页
 *  @warning 当单个视图之间的间距为 0 时可以直接设置 cycleScrollView的pagingEnabled属性为YES，这样滑动的行为就是系统默认的动画样式
 */
@property (assign, nonatomic) BOOL pagingEnabled;

/** 滑动视图的滑动方向 */
@property (assign, nonatomic) CGCycleViewScrollDirection scrollDirection;

/** 是否开启滑动视图滑动方向的监听 */
//@property (nonatomic, assign) BOOL enableScrollDirectionMonitor;

/** 滑动视图滑动的方向 */
//@property (nonatomic, assign, readonly) CGScrollDirectionType scrollDirectionType;

/** 
 *  关闭默认计时器设定(默认为NO)
 *  开启后CGCycleScrollView不对计时器进行管理，需要使用者自行管理，
 *  不包含滑动过程中的控制，仅控制加入离开屏幕和移除父视图的控制
 */
@property (assign, nonatomic) BOOL isCloseDefaultTimerSetting;

#pragma mark - 缓存设置
/**
 *  是否缓存已创建的视图
 *  当设值为YES时，maxCacheCountForViews属性为0时，默认设置为 5
 */
@property (assign, nonatomic) BOOL isCacheViews;

/** 缓存的最大数 */
@property (assign, nonatomic) NSUInteger maxCacheCountForViews;

/** 被缓存的视图 */
@property (strong, nonatomic, readonly) NSMutableDictionary *cacheViews;

/**
 *  刷新视图
 */
- (void)reloadAllView;

/**
 *  刷新分页视图 
 */
- (void)reloadPageView;

/**
 *  清除缓存
 */
- (void)removeAllCacheViews;

/**
 *  创建循环滑动视图
 *
 *  @param frame             滑动视图的区域
 *  @param delayTimeInterval 自动滑动延长的时间
 */
- (instancetype)initWithFrame:(CGRect)frame delayTimeInterval:(NSTimeInterval)delayTimeInterval;

#pragma mark - 计时器控制
/**
 *  计时器在默认情况下，加入屏幕开启，离开屏幕暂停，移除父视图时停止
 *
 */

/** 开始计时器 */
- (void)startAutoScroll;
/** 暂停计时器 */
- (void)pasueAutoScroll;
/** 暂停计时器 */
- (void)stopAutoScroll;
@end
