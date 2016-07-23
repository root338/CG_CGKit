//
//  CGLayoutManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN
@class CGLayoutManager;

@protocol CGLayoutManagerDelegate <NSObject>

@optional
/** 当添加的约束重复时的处理方法 */
- (NSLayoutConstraint *)layoutManager:(CGLayoutManager *)layoutManager existedConstraint:(NSLayoutConstraint *)oldConstraint newConstraint:(NSLayoutConstraint *)newConstraint;

@end

/** 添加约束的管理类 */
@interface CGLayoutManager : CGBaseObject

/** 约束管理的目标视图 */
@property (nonatomic, weak) UIView *targetView;

@property (nullable, nonatomic, weak) id<CGLayoutManagerDelegate> delegate;

/** 相关的所有约束 */
@property (nullable, nonatomic, strong, readonly) NSArray<NSLayoutConstraint *> *relatedAllConstraints;

/** 获取视图自身相关约束 */
- (nullable NSLayoutConstraint *)cg_getConstraintsWithLayoutAttribute:(NSLayoutAttribute)att;

/** 设置已经添加的约束 */
- (BOOL)setupDidAddToConstraint:(NSLayoutConstraint *)constraint error:( NSError * _Nullable *)error;
@end

NS_ASSUME_NONNULL_END