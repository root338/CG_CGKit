////
////  CGSingleViewConstraintsManager.h
////  TestCG_CGKit
////
////  Created by apple on 16/7/24.
////  Copyright © 2016年 apple. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@import UIKit;
//
//NS_ASSUME_NONNULL_BEGIN
//
///** 处理约束中的错误类型 */
//typedef NS_ENUM(NSInteger, CGHandleConstraintErrorType) {
//    /** 没有错误 */
//    CGHandleConstraintErrorTypeNone = 0,
//    
//    //添加约束时
//    /** 添加的约束不属于管理的视图 */
//    CGHandleConstraintErrorTypeDoesNotBelongTargetView,
//    
//    //已存在的约束检验时
//    /** 该约束不存在任何视图上 */
//    CGHandleConstraintErrorTypeNotTargetView,
//    
//};
//
//@class CGSingleViewConstraintsManager;
//
//@protocol CGSingleViewConstraintsManagerDelegate <NSObject>
//
//@required
//
//@optional
///**
// *  当添加的约束重复时的处理方法
// *
// */
//- (NSLayoutConstraint *)constraintsManager:(CGSingleViewConstraintsManager *)layoutManager existedConstraint:(NSLayoutConstraint *)oldConstraint newConstraint:(NSLayoutConstraint *)newConstraint;
//
//@end
///** 单个视图的约束管理类 */
//@interface CGSingleViewConstraintsManager : NSObject
//
///** 约束管理的目标视图 */
//@property (nullable, nonatomic, weak) UIView *targetView;
//
//@property (nullable, nonatomic, weak) id<CGSingleViewConstraintsManagerDelegate> delegate;
//
///** 是否每次验证保存的约束是否可用 @param 默认为NO，不需要验证 */
//@property (nonatomic, assign) BOOL enableAlwaysVerifyAvailable;
//
///** 相关的所有约束 */
//@property (nullable, nonatomic, strong, readonly) NSArray<NSLayoutConstraint *> *relatedAllConstraints;
//
///** 获取视图自身相关约束 */
////- (nullable NSLayoutConstraint *)cg_getConstraintsWithLayoutAttribute:(NSLayoutAttribute)att;
//
///** 设置已经添加的约束 */
//- (BOOL)setupDidAddToConstraint:(NSLayoutConstraint *)constraint;
//
///**
// *  移除指定的约束
// *
// *  @param constraint   指定的约束
// *  @param existingView 约束所存在的视图
// *
// *  @return 返回是否移除成功
// */
//- (BOOL)removeConstraint:(NSLayoutConstraint *)constraint existingView:(nullable UIView *)existingView;
//
//@end
//
//NS_ASSUME_NONNULL_END