//
//  CGCycleBrowseScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseView.h"
#import "CGBlockdDefinitionHeader.h"

@class CGCycleScrollView;
/**
 *  分页视图的位置
 */
typedef NS_ENUM(NSInteger, CGCycleBrowseImageViewPageControlPosition) {
    /**
     *  显示父视图底部
     */
    CGCycleBrowseImageViewPageControlPositionBottom,
    
    /**
     *  显示父视图顶部
     */
    CGCycleBrowseImageViewPageControlPositionTop,
};

/** 浏览视图 */
@interface CGCycleBrowseImageScrollView : CGBaseView

#pragma mark - 循环视图
/** 加载的数据 图片链接 */
@property (strong, nonatomic) NSMutableArray<NSString *> *dataSource;

/** 滑动视图相对本视图的外边距 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInset;

/** 滑动视图内部视图中子视图的外边距 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsetForSubview;

/** 图像视图之间的间距 */
@property (nonatomic, assign) CGFloat contentViewSpace;

/** 点击回调 */
@property (copy, nonatomic) cg_singleValueCallback clickIndexCallback;

/** 当前索引改变时回调 */
@property (copy, nonatomic) cg_singleValueCallback currentIndexDidChangeCallback;

/** 图片加载的类型，默认UIViewContentModeScaleAspectFit */
@property (assign, nonatomic) UIViewContentMode imageViewContentMode;

/** 设置加载的图像视图 */
@property (nonatomic, copy) void (^setupImageViewContent) (UIImageView *imageView, NSInteger index);

@property (strong, nonatomic, readonly) CGCycleScrollView *cycleScrollView;

#pragma mark - pageControl
/** 是否显示分页视图，默认NO */
@property (assign, nonatomic) BOOL isHidePageControl;

/** 分页视图的位置 */
@property (assign, nonatomic) CGCycleBrowseImageViewPageControlPosition positionForPageControl;

/** 改变pageControl视图的显示区域，优先级大于positionForPageControl */
@property (copy, nonatomic) cg_setupViewRectToSuperview setupPageControlFrame;

/** 分页视图 */
@property (strong, nonatomic, readonly) UIPageControl *pageControl;

/**
 *  创建图片浏览视图
 *
 *  @param dataSource   需要添加的数据源
 *  @param extractBlock 提取dataSource指定图片值（当dataSource为字符串数组时不需要提取）
 *
 *  @return 返回创建好的对象
 */
+ (instancetype)createCycleBrowseImageScrollViewWithImages:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock;

/**
 *  设置加载图片的数据
 *
 *  @param dataSource   需要添加的数据源
 *  @param extractBlock 提取dataSource指定图片值（当dataSource为字符串数组时不需要提取）
 */
- (void)setupDataSourceWithObject:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock;
@end
