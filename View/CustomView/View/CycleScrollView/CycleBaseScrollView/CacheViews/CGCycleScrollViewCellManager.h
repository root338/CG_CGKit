//
//  CGCycleScrollViewCellManager.h
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class CGCycleScrollViewCell, CGCycleScrollView;
NS_ASSUME_NONNULL_BEGIN

/** 循环滑动视图的cell的管理类 */
@interface CGCycleScrollViewCellManager : NSObject

@property (nullable, nonatomic, weak) CGCycleScrollView *cycleView;

#pragma mark - 创建缓存标识
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier;

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

#pragma mark - 获取cell

- (nullable __kindof CGCycleScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
//- (nullable __kindof CGCycleScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndex:(NSUInteger *)index;

- (__kindof CGCycleScrollViewCell *)cellForIndex:(NSUInteger)index;


@end

NS_ASSUME_NONNULL_END