//
//  CGCycleScrollViewBuildLayout.h
//  TestCG_CGKit
//
//  Created by DY on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class CGCycleCellConfigModel, CGCycleScrollView;

NS_ASSUME_NONNULL_BEGIN

/** 滑动视图的布局设置 */
@interface CGCycleScrollViewBuildLayout : NSObject

@property (nullable, nonatomic, weak) CGCycleScrollView *cycleScrollView;
/** 循环滑动视图 */
@property (nullable, nonatomic, weak) UIScrollView *scrollView;
/** 用来标志的当前索引 */
@property (nonatomic, assign) NSInteger currentIndex;

//循环滑动下，必须给滑动视图留下向两端滑动的空间（水平／垂直），所以这两个都是不可见的cell
//不循环滑动下，由于滑动视图不是按照子视图的所有大小来决定，所以滑动之间时也需要留有两端的空间

@property (nullable, nonatomic, strong) CGCycleCellConfigModel *firstCellConfig;
@property (nullable, nonatomic, strong) CGCycleCellConfigModel *lastCellConfig;

/** 设置重新刷新后需要偏移的坐标 */
- (CGPoint)setupScrollViewDidReloadContentOffset;

/** 设置cell的布局 */
- (nullable NSArray<CGCycleCellConfigModel *> *)setupBuildLayoutCells;


@end

NS_ASSUME_NONNULL_END