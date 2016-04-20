//
//  UIView+CGCreateConstraint.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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