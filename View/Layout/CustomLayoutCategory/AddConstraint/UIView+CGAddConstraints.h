//
//  UIView+CGAddConstraints.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/20.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGSearchConstraintTypeHeader.h"
#import "CGLayoutConstraintsTypeHeader.h"

#import "UIView+CGAddConstraintStatus.h"
#import "UIView+CreateAutoLayoutTypeView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^CGSetupConstraints) (void);

#pragma mark - 设置视图与视图四周的约束

@interface UIView (CGViewAndViewConstraints)

- (NSArray<NSLayoutConstraint *> *)cg_autoEdgeEqualWithViews:(NSArray<UIView *> *)views layoutAttribute:(NSLayoutAttribute)layoutAttribute;


@end

#pragma mark - 设置与视图控制器视图的四周约束

@interface UIView (CGViewControllerConstraints)

/** 设置与视图控制器视图的四周约束为 0 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToViewController:(UIViewController *)viewController;

/** 设置与视图控制器视图的四周约束为 0 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToViewController:(UIViewController *)viewController exculdingEdge:(CGLayoutEdge)edge;

/** 设置与视图控制器视图的四周约束 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets;

/** 
 *  设置与视图控制器视图的四周约束
 *  @param key为 @(NSLayoutAttribute) 类型
 */
- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets;

/** 设置与视图控制器视图的四周约束，并忽略指定边 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge;

/** 设置与视图控制器视图指定四周的间距 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets edge:(CGLayoutOptionEdge)edge;

/** 设置与视图控制器视图指定四周的间距 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets edge:(CGLayoutOptionEdge)edge relation:(NSLayoutRelation)relation;

/** 
 *  设置与视图控制器视图的四周约束，并忽略指定边
 *  @param key为 @(NSLayoutAttribute) 类型
 */
- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToViewController:(UIViewController *)viewController withInsets:(UIEdgeInsets)insets exculdingEdge:(CGLayoutEdge)edge;

@end

#pragma mark - 设置与父视图的四周约束
/** 添加与父视图四周的约束 */
@interface UIView (CGSuperviewConstranints)

/** 设置与父视图四周的间距为0 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperview;

/** 设置与父视图四周的间距为0，并忽略哪边边 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesInsetsZeroToSuperviewExcludingEdge:(CGLayoutEdge)layoutEdge;

/** 设置与父视图四周的间距 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets;

/** 设置与父视图四周的间距 */
- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets;

/** 设置与父视图四周的间距，并忽略哪边边 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge;

/** 设置与父视图四周的间距，并忽略哪边边 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingOptionEdge:(CGLayoutOptionEdge)edge;

/** 设置与父视图指定四周的间距 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithEdge:(CGLayoutOptionEdge)edge insets:(UIEdgeInsets)insets;

/** 设置与父视图指定四周的间距 */
- (NSArray<NSLayoutConstraint *> *)cg_autoEdgesToSuperviewEdgesWithEdge:(CGLayoutOptionEdge)edge insets:(UIEdgeInsets)insets relation:(NSLayoutRelation)relation;

/** 设置与父视图四周的间距，并忽略哪边边 */
- (NSDictionary<NSNumber *, NSLayoutConstraint *> *)cg_d_autoEdgesToSuperviewEdgesWithInsets:(UIEdgeInsets)insets excludingEdge:(CGLayoutEdge)edge;

@end

#pragma mark - 设置与父视图的单个约束
/** 添加与父视图相关的单个约束 */
@interface UIView (CGSuperviewConstranint)

/** 设置与父视图之间的约束（两者相同的边值类型） */
- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute;

/** 设置与父视图之间的约束（两者相同的边值类型，约束类型） */
- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation;

/** 设置与父视图之间的约束（两者相同的边值类型，间距） */
- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset;

/** 设置与父视图之间的约束（两者相同的边值类型，约束类型，间距） */
- (NSLayoutConstraint *)cg_autoConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

@end

#pragma mark - 与视图控制器设置的单个约束
/** 添加与 viewController 相关的约束 */
@interface UIView (CGViewControllerConstraint)

/** 设置 topLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController;

/** 设置 topLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** 设置 topLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

/** 设置 topLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier;

/** 设置 bottomLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier;

@end

#pragma mark - 设置视图中心对齐

@interface UIView (CGViewAxisConstraint)

/** 设置去指定视图的对齐 */
- (NSLayoutConstraint *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView;

/** 设置与指定视图的对齐，并设置偏移的间距 */
- (NSLayoutConstraint *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset;

/** 设置与父视图对齐的边 */
- (NSLayoutConstraint *)cg_autoCenterToSuperviewWithAxis:(CGAxis)axis;

/** 设置与父视图中心对齐 */
- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSuperview;

/** 设置与指定视图中心对齐 */
- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSameAxisOfView:(UIView *)otherView;

/** 设置与指定视图中心对齐，并设置偏移的坐标 */
- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSameAxisOfView:(UIView *)otherView withOffset:(CGPoint)offset;
@end

#pragma mark - 设置视图自身的大小

@interface UIView (CGViewDimensionConstraint)

/** 设置指定大小的长度 */
- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength;

/** 设置视图的大小 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupViewSize:(CGSize)viewSize;

/** 设置指定大小的长度并设置约束类型 */
- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation;

/** 设置视图与指定视图大小相等 */
- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)view;

/** 设置视图宽高与指定视图相等 */
- (NSArray<NSLayoutConstraint *> *)cg_autoDimensionEqualView:(UIView *)view;

/** 设置视图与指定视图大小的关系 */
- (NSLayoutConstraint *)cg_autoDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation;

/** 设置视图宽 : 高 的值 */
- (NSLayoutConstraint *)cg_autoDimensionScale:(CGFloat)scale;
@end


@interface UIView (CGAddConstraintForInverse)

/** 设置两视图之间的约束 */
- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2;

/** 设置两视图之间的约束，间距 */
- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型(单个)，约束类型, 间距) */
- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation;

/** 设置两对象之间的约束(边值类型(单个)，约束类型, 间距) */
- (NSLayoutConstraint *)cg_autoInverseAttribute:(CGLayoutEdge)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c;



@end

#pragma mark - 设置视图与指定视图之间的约束
@interface UIView (CGAddConstraint)


+ (void)cg_autoSetPriority:(UILayoutPriority)priority forConstraints:(CGSetupConstraints)constraints;

+ (void)cg_autoUpdateConstraints:(CGSetupConstraints)constraints;
+ (void)cg_autoSetUpdate:(BOOL)updateConstraints forConstraints:(CGSetupConstraints)constraints;

///** 设置两对象之间的约束(边值类型，约束类型，间距) */
//- (NSLayoutConstraint *)cg_autoConstrainAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(__kindof UIView *)otherView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;
//
///** 设置两对象之间的约束(边值类型，约束类型，间距，比例值) */
//- (NSLayoutConstraint *)cg_autoConstrainAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofView:(__kindof UIView *)otherView withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSArray<NSLayoutConstraint *> *)cg_autoAttributeOptionEqual:(CGLayoutOptionEdge)optionEdge toItem:(UIView *)view2;

/** 设置两对象之间的约束(边值类型，约束类型, 间距) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSArray<NSLayoutConstraint *> *)cg_autoAttributeOptionEqual:(CGLayoutOptionEdge)optionEdge toItem:(UIView *)view2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型(单个)，约束类型, 间距) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSArray<NSLayoutConstraint *> *)cg_autoAttributeOptionEqual:(CGLayoutOptionEdge)optionEdge toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2;

/** 设置两对象之间的约束(边值类型，间距) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2;

/** 设置两对象之间的约束(边值类型，约束类型，间距) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型，间距，比例值) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;



@end


NS_ASSUME_NONNULL_END