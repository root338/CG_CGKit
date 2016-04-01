//
//  UIView+CGAddConstraints.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/20.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CreateAutoLayoutTypeView.h"

NS_ASSUME_NONNULL_BEGIN

/** 添加与 viewController 相关的约束 */
@interface UIView (CGViewControllerConstraints)

/** 设置 topLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;
/** 设置 topLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_topLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;
/** 设置 bottomLayoutGuide 与视图顶部的约束(间距) */
- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset;
/** 设置 bottomLayoutGuide 与视图顶部的约束(间距，约束类型) */
- (NSLayoutConstraint *)cg_bottomLayoutGuideOfViewController:(UIViewController *)viewController withInset:(CGFloat)inset relatedBy:(NSLayoutRelation)relation;

@end

@interface UIView (CGAddConstraints)
/** 设置两对象之间的约束(边值类型，约束类型) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2;
/** 设置两对象之间的约束(边值类型，约束类型，间距) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 constant:(CGFloat)c;
/** 设置两对象之间的约束(边值类型，约束类型，间距，比例值) */
- (NSLayoutConstraint *)cg_attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(nullable id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

@end
NS_ASSUME_NONNULL_END