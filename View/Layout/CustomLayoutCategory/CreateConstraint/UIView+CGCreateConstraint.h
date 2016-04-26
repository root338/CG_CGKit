//
//  UIView+CGCreateConstraint.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGLayoutConstraintsTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN


/** 添加与父视图相关的单个约束 */
@interface UIView (CGCreateSuperviewConstranint)

/** 设置与父视图之间的约束（两者相同的边值类型） */
- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute;

/** 设置与父视图之间的约束（两者相同的边值类型，约束类型） */
- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute relation:(NSLayoutRelation)relation;

/** 设置与父视图之间的约束（两者相同的边值类型，间距） */
- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset;

/** 设置与父视图之间的约束（两者相同的边值类型，约束类型，间距） */
- (NSLayoutConstraint *)cg_createConstrainToSuperviewAttribute:(NSLayoutAttribute)attribute withOffset:(CGFloat)offset relation:(NSLayoutRelation)relation;

@end

/** 添加与 viewController 相关的约束 */
@interface UIView (CGCreateViewControllerConstraint)

/** 设置 topLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController;

/** 设置 topLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** 设置 topLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_createTopLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

/** 设置 bottomLayoutGuide 与视图顶部的约束 */
- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;

/** 设置 bottomLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_createBottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

@end

@interface UIView (CGCreateViewAxisConstraint)

/** 设置去指定视图的对齐 */
- (NSLayoutConstraint *)cg_createAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView;

/** 设置与指定视图的对齐，并设置偏移的间距 */
- (NSLayoutConstraint *)cg_createAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView withOffset:(CGFloat)offset;
@end

@interface UIView (CGCreateViewDimensionConstraint)

/** 设置指定大小的长度 */
- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength;

/** 设置指定大小的长度并设置约束类型 */
- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength relation:(NSLayoutRelation)relation;

/** 设置视图与指定视图大小相等 */
- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension equalView:(UIView *)view;

/** 设置视图与指定视图大小的关系 */
- (NSLayoutConstraint *)cg_createDimension:(CGDimension)dimension view:(UIView *)view relatedBy:(NSLayoutRelation)relation;

@end

@interface UIView (CGCreateConstraint)

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2;

/** 设置两对象之间的约束(边值类型，约束类型, 间距) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型(单个)，约束类型, 间距) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 relatedBy:(NSLayoutRelation)relation constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2;

/** 设置两对象之间的约束(边值类型，间距) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attribute toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2;

/** 设置两对象之间的约束(边值类型，约束类型，间距) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;

/** 设置两对象之间的约束(边值类型，约束类型，间距，比例值) */
- (NSLayoutConstraint *)cg_createAttribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

@end
NS_ASSUME_NONNULL_END