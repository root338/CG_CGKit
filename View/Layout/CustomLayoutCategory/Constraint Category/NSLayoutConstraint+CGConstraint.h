//
//  NSLayoutConstraint+CGConstraint.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (CGConstraint)

/** 获取添加该约束的视图 */
- (nullable __kindof UIView *)cg_getDidAddLayoutConstraintView;

- (void)setupLayoutPriority:(UILayoutPriority)priority;
@end
NS_ASSUME_NONNULL_END