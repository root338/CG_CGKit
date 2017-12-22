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

/** 开启单图片视图循环滑动 */
@property (nonatomic, assign) BOOL enableSingleImageCycleScroll;

/** 图片是否可以缩放 */
@property (nonatomic, assign, readonly) BOOL imageScrollZoom;

/** 图片大小等于视图大小，否则按照图片比例与视图比例计算图片大小, 默认根据初始化方法(initWithFrame:imageScrollZoom:)的imageScrollZoom来进行设置，当为YES时为NO，为NO时为YES */
@property (nonatomic, assign) BOOL imageViewSizeEqualViewSize;

#pragma mark - 循环视图
/** 加载的数据， 可以是图片的链接 https:// , 图片 */
@property (strong, nonatomic) NSArray *dataSource;

/** 滑动视图相对本视图的外边距 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInset;

/** 滑动视图内部视图中子视图的外边距 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsetForSubview;

/** 图像视图之间的间距 */
@property (nonatomic, assign) CGFloat contentViewSpace;

/** 点击回调 */
@property (copy, nonatomic) cg_singleValueCallback clickIndexCallback;

@property (nonatomic, copy) void (^clickImageCallback) (NSInteger index, UIImageView *imageView);

/** 当前索引改变时回调 */
@property (copy, nonatomic) cg_singleValueCallback currentIndexDidChangeCallback;

/** 图片加载的类型，默认UIViewContentModeScaleAspectFit */
@property (assign, nonatomic) UIViewContentMode imageViewContentMode;

/** 设置加载的图像视图 */
@property (nonatomic, copy) void (^setupImageViewContent) (UIImageView *imageView, NSInteger index);

/** 自定义加载图片的链接 */
@property (nonatomic, copy) void (^setupLoadImage) (NSString *imageURLString, UIImageView *imageView);

/** 刷新完成后回调 */
@property (nonatomic, copy) void (^reloadDataDidFinishCallback) (void);

@property (strong, nonatomic, readonly) CGCycleScrollView *cycleScrollView;

#pragma mark - pageControl
/** 是否隐藏分页视图，默认NO */
@property (assign, nonatomic) BOOL isHidePageControl;

/** 距离边界的距离 */
@property (nonatomic, assign) CGFloat pageControlVerticalSpace;

/** 分页视图的位置 */
@property (assign, nonatomic) CGCycleBrowseImageViewPageControlPosition positionForPageControl;

/** 改变 pageControl 视图的显示区域，优先级大于positionForPageControl */
@property (copy, nonatomic) cg_setupViewRectToSuperview setupPageControlFrame;

/** 分页视图 */
@property (strong, nonatomic, readonly) UIPageControl *pageControl;

/** 滑动到指定索引图片位置 */
- (void)scrollBrowseImageCellToIndex:(NSInteger)index;

/**
 *  创建图片浏览视图
 *
 *  @param dataSource   需要添加的数据源
 *  @param extractBlock 提取dataSource指定图片值（当dataSource为字符串数组时不需要提取）
 *
 *  @return 返回创建好的对象
 */
+ (instancetype)createCycleBrowseImageScrollViewWithImages:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock;

- (instancetype)initWithFrame:(CGRect)frame imageScrollZoom:(BOOL)imageScrollZoom NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 *  设置加载图片的数据
 *
 *  @param dataSource   需要添加的数据源
 *  @param extractBlock 提取dataSource指定图片值（当dataSource为字符串数组时不需要提取）
 */
- (void)setupDataSourceWithObject:(NSArray *)dataSource extractBlock:(cg_getSingleValueForTargetObject)extractBlock;
- (void)setupDataSourceWithObject:(NSArray *)dataSource startIndex:(NSInteger)startIndex extractBlock:(cg_getSingleValueForTargetObject)extractBlock;

@end
