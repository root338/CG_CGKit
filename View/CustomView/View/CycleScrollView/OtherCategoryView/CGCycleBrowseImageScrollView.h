//
//  CGCycleBrowseScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBlockdDefinitionHeader.h"

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
@interface CGCycleBrowseImageScrollView : UIView

/** 加载的数据 图片链接 */
@property (strong, nonatomic) NSMutableArray<NSString *> *dataSource;

/** 外边距 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInset;

/** 是否显示分页视图，默认NO */
@property (assign, nonatomic) BOOL isHidePageControl;

@property (assign, nonatomic) CGCycleBrowseImageViewPageControlPosition positionForPageControl;
@property (strong, nonatomic, readonly) UIPageControl *pageControl;


/** 点击回调 */
@property (copy, nonatomic) cg_singleValueCallback clickIndexCallback;

@property (copy, nonatomic) cg_singleValueCallback currentIndexDidChangeCallback;
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
