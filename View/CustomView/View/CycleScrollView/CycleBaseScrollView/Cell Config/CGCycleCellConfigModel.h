//
//  CGCycleCellConfigModel.h
//  TestCG_CGKit
//
//  Created by DY on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class CGCycleScrollViewCell;

NS_ASSUME_NONNULL_BEGIN
/** 需要加载的cell的配置 */
@interface CGCycleCellConfigModel : NSObject

/** 索引 */
@property (nonatomic, assign) NSInteger index;

/** 显示区域 */
@property (nonatomic, assign) CGRect    frame;

@property (nullable, nonatomic, strong) CGCycleScrollViewCell *cell;

- (instancetype)initWithIndex:(NSInteger)index;

- (void)clearAllValue;
@end
NS_ASSUME_NONNULL_END