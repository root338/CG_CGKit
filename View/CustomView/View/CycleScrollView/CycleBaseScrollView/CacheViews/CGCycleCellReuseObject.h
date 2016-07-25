//
//  CGCycleCellReuseObject.h
//  TestCG_CGKit
//
//  Created by DY on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@class CGCycleScrollViewCell;
NS_ASSUME_NONNULL_BEGIN

/** cell重用的类型 */
typedef NS_ENUM(NSInteger, CGCycleCellReuseType) {
    /** 类创建方式重建 */
    CGCycleCellReuseTypeClass,
    /** nib创建方式重建 */
    CGCycleCellReuseTypeNib,
};

@interface CGCycleCellReuseObject : NSObject

/** cell重用的类型 */
@property (nonatomic, assign, readonly) CGCycleCellReuseType cellReuseType;

@property (nullable, nonatomic, strong) Class cellClass;
@property (nullable, nonatomic, strong) UINib *nib;

@property (nullable, nonatomic, copy, readonly) NSString *reuseIdentifier;

#pragma mark - 创建
+ (instancetype)createCellReuseWithTargetObj:(id)targetObj identifier:(NSString *)identifier;

- (instancetype)initWithTargetObj:(id)targetObj identifier:(NSString *)identifier;

/** 获取指定类型的cell */
- (__kindof CGCycleScrollViewCell *)cell;
/** 被移除视图的cell，移动到未使用cell数组中 */
- (void)didRemoveViewCell:(CGCycleScrollViewCell *)cell;
@end

NS_ASSUME_NONNULL_END