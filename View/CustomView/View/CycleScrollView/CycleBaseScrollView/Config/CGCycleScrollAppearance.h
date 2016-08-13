//
//  CGCycleScrollAppearance.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGCycleScrollViewDefineHeader.h"

/** 滑动视图的一些配置选项 */
@interface CGCycleScrollAppearance : CGBaseObject

/** 滑动的方式 */
@property (nonatomic, assign) CGCycleViewScrollDirection scrollDirection;

/** 是否循环滑动 */
@property (nonatomic, assign) BOOL isCycle;

/** 是否自动滑动 */
@property (nonatomic, assign) BOOL isAutoScroll;
/** 自动滑动间隔的秒数 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

//通用cell设置
/** 设置cell的大小，默认CGSizeZero，设置为与滑动视图相同大小 */
@property (nonatomic, assign) CGSize cellSize;
/** cell之间的间距 */
@property (nonatomic, assign) CGFloat cellSpace;

+ (instancetype)defaultAppearance;
@end
