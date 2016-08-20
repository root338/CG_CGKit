//
//  UIView+CGAddConstraintsForSubviews.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CGTwoSubviewsConstraintsAppearance;

/** 设置子视图的约束 */
@interface UIView (CGAddConstraintsForSubviews)

#pragma mark - 两个子视图的快速设置

/** 设置两个子视图的约束 */
- (nullable NSArray<NSLayoutConstraint *> *)cg_autoTwoSubviewsWithConfig:(CGTwoSubviewsConstraintsAppearance *)config;


@end

NS_ASSUME_NONNULL_END