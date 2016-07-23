//
//  UIView+CGAddConstraintStatus.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGAddConstraintStatus)

/**
 *  是否在添加中更新约束
 *  @param 当设置为YES时，在添加约束前会检查添加约束是否存在，如果存在更新约束值 默认为NO
 */
@property (nonatomic, assign) BOOL isUpdateAddConstraint;

/**
 *  全局设置添加约束的优先值 (0, 1000]
 *  @warning    创建约束的优先级只能在创建阶段进行设置，当添加到视图后无法进行设置，会发生运行错误
 */
@property (nonatomic, assign) UILayoutPriority layoutPriorityForConstraint;

/** 更新约束 */
- (nullable NSLayoutConstraint *)cg_updateConstraintWithAtt1:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)item2 att2:(NSLayoutAttribute)att2 multiplier:(CGFloat)multiplier constant:(CGFloat)c commonSuperview:(nullable UIView *)commonSuperview;
@end

@interface UIView (CGSearchConstraint)

/** 搜索已设置的约束 */
- (nullable NSLayoutConstraint *)cg_searchAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2;

/** 搜索已设置的约束(约束添加的视图) */
- (nullable NSLayoutConstraint *)cg_searchAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 commonSuperview:(UIView *)commonSuperview;

@end

NS_ASSUME_NONNULL_END