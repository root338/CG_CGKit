//
//  UIView+CGUpdateConstraints.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGLayoutConstraintsTypeHeader.h"
#import "UIView+CreateAutoLayoutTypeView.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 设置与视图控制器视图的四周约束

@interface UIView (CGUpdateViewControllerConstraints)

/** 设置与视图控制器视图的四周约束为 0 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesInsetsZeroToViewController:(UIViewController *)viewController;

/** 设置与视图控制器视图的四周约束 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets;

/** 设置与视图控制器视图的四周约束，并忽略指定边 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge;

@end

#pragma mark - 设置与父视图的四周约束
/** 添加与父视图四周的约束 */
@interface UIView (CGUpdateSuperviewConstranints)

/** 设置与父视图四周的间距为0 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesInsetsZeroToSuperview;
/** 设置与父视图四周的间距 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets;
/** 设置与父视图四周的间距，并忽略哪边边 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge;

@end

#pragma mark - 设置与父视图的单个约束
/** 添加与父视图相关的单个约束 */
@interface UIView (CGUpdateSuperviewConstranint)

/** 设置与父视图之间的约束（两者相同的边值类型） */
- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute;

/** 设置与父视图之间的约束（两者相同的边值类型，约束类型） */
- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation;

/** 设置与父视图之间的约束（两者相同的边值类型，间距） */
- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset;

/** 设置与父视图之间的约束（两者相同的边值类型，约束类型，间距） */
- (NSLayoutConstraint *)cg_updateAutoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

@end

#pragma mark - 与视图控制器设置的单个约束
/** 添加与 viewController 相关的约束 */
@interface UIView (CGSuperViewControllerConstraint)

/** 设置 topLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_updateTopLayoutGuideOfViewController:(UIViewController *)viewController;

/** 设置 topLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_updateTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** 设置 topLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_updateTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

/** 设置 bottomLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_updateBottomLayoutGuideOfViewController:(UIViewController *)viewController;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_updateBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_updateBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

@end

#pragma mark - 设置视图中心对齐

@interface UIView (CGUpdateViewAxisConstraint)

/** 设置去指定视图的对齐 */
- (NSLayoutConstraint *)cg_updateAutoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView;

/** 设置与指定视图的对齐，并设置偏移的间距 */
- (NSLayoutConstraint *)cg_updateAutoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset;

/** 设置与指定视图中心对齐 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoCenterToSameAxisOfView:(UIView *)otherView;

/** 设置与指定视图中心对齐，并设置偏移的坐标 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoCenterToSameAxisOfView:(UIView *)otherView withOffset:(CGPoint)offset;
@end

#pragma mark - 设置视图自身的大小

@interface UIView (CGUpdateViewDimensionConstraint)

/** 设置指定大小的长度 */
- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength;

/** 设置视图的大小 */
- (NSArray<NSLayoutConstraint *> *)cg_updateAutoSetupViewSize:(CGSize)viewSize;

/** 设置指定大小的长度并设置约束类型 */
- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation;

/** 设置视图与指定视图大小相等 */
- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension equalView:(UIView *)view;

/** 设置视图与指定视图大小的关系 */
- (NSLayoutConstraint *)cg_updateAutoDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation;

@end

#pragma mark - 更新 与对象设置的单个约束
@interface UIView (CGUpdateConstraint)

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2;

/** 设置两对象之间的约束(边值类型，约束类型, 间距) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型(单个)，约束类型, 间距) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2;

/** 设置两对象之间的约束(边值类型，间距) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2;

/** 设置两对象之间的约束(边值类型，约束类型，间距) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/** 更新两对象之间的约束(边值类型，约束类型，间距，比例值) */
- (NSLayoutConstraint *)cg_updateAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

@end

@interface UIView (CGSearchConstraint)

/** 搜索已设置的约束 */
- (nullable NSLayoutConstraint *)cg_searchAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2;

/** 搜索已设置的约束(约束添加的视图) */
- (nullable NSLayoutConstraint *)cg_searchAttribute:(NSLayoutAttribute)att1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 commonSuperview:(UIView *)commonSuperview;

@end
NS_ASSUME_NONNULL_END