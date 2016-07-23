//
//  CGDoubleLayoutBaseView.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"
#import "CGAlignmentHeader.h"
#import "CGLayoutMarginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/** 双数视图基类 */
@interface CGDoubleLayoutBaseView : CGBaseView<CGDoubleLayoutDelegate>

//--------------------------------------------------------------------------
//-------在添加之前设置，还不支持值变化的实时改变视图
//--------------------------------------------------------------------------

/** 两个视图之间的间距 */
@property (nonatomic, assign) CGFloat targetViewsBetweenSapce;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;
/** 第一个视图的外边距 */
@property (nonatomic, assign) UIEdgeInsets firstTargetViewEdgeInsets;
/** 第二个视图的外边距 */
@property (nonatomic, assign) UIEdgeInsets secondTargetViewEdgeInsets;

/** 设置第一个视图的大小 */
@property (nonatomic, assign) CGSize firstItemSize;
/** 设置第二个视图的大小 */
@property (nonatomic, assign) CGSize secondItemSize;

/** 两个视图之间的对齐方式 */
@property (nonatomic, assign) CGAlignmentType alignment;



/** 关闭延迟0s后设置约束 */
@property (nonatomic, assign) BOOL disableRunLoopSetupConstraints;

@property (nonatomic, strong, readonly) UIView *contentView;

/** 第一个视图 */
- (UIView *)cg_layoutFirstTargetView;
/** 第二个视图 */
- (UIView *)cg_layoutSecondTargetView;

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
/** 设置约束 */
- (void)setupViewConstraints;

/** 更新设置视图约束布局 */
//- (void)updateSetupViewLayout;
@end

NS_ASSUME_NONNULL_END