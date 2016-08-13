//
//  CGCycleScrollViewDefineHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGCycleScrollViewDefineHeader_h
#define CGCycleScrollViewDefineHeader_h

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

/** cell的位置 */
typedef NS_OPTIONS(NSInteger, CGCycleCellPosition) {
    
    CGCycleCellPositionNone                 = 0,
    
    CGCycleCellPositionTop                  = 1 << 0,
    CGCycleCellPositionCenteredVertically   = 1 << 1,
    CGCycleCellPositionBottom               = 1 << 2,
    
    CGCycleCellPositionLeft                 = 1 << 3,
    CGCycleCellPositionCenteredHorizontally = 1 << 4,
    CGCycleCellPositionRight                = 1 << 5,
};

/** 滑动时视图根据滑动时的样式变化 */
typedef NS_ENUM(NSInteger, CGCycleViewScrollAnimationStyle) {
    
    CGCycleViewScrollAnimationStyleNone,
    CGCycleViewScrollAnimationStyleAnimation1,
};

#endif /* CGCycleScrollViewDefineHeader_h */
