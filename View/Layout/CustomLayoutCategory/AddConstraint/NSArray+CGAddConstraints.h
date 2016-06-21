//
//  NSArray+CGAddConstraints.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/17.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGLayoutConstraintsTypeHeader.h"


NS_ASSUME_NONNULL_BEGIN
/** 子视图的排列类型 */
typedef NS_ENUM(NSInteger, CGSubviewsArrangementType) {
    
    /** 水平铺展 */
    CGSubviewsArrangementTypeHorizontal,
    /** 垂直铺展 */
    CGSubviewsArrangementTypeVertical,
};

/** 设置subView之间的间距 */
typedef CGFloat (^CGSetupSubviewSpace) (UIView *view1, UIView *view2);

/** 设置子视图之间间距的NSLayoutRelation值 */
typedef NSLayoutRelation (^CGSetupSubviewsLayoutRelation) (UIView *view1, CGLayoutEdge view1LayoutEdge, UIView *view2, CGLayoutEdge view2LayoutEdge);

/** 设置子视图相对于父视图的NSLayoutRelation值 */
typedef NSLayoutRelation (^CGSetupSubviewLayoutRelation) (UIView *view, CGLayoutEdge layoutEdge);

@interface NSArray (CGAddViewSubviewsConstraints)

/** 子视图之间统一的间距 */
@property (nonatomic, assign) CGFloat subviewsSpaceValue;

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayout;
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayout;

/**
 *  设置约束  父视图 垂直
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/**
 *  设置约束  父视图 水平
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsSpace:(CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/** 
 *  设置约束  父视图
 *  @param  arrangementType         子视图排列的类型
 *  @param  marginInsets            子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/**
 *  设置约束  父视图
 *  @param  arrangementType             子视图排列的类型
 *  @param  marginInsets                子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距，可以在其中设置返回view的其它约束
 *  @param  setupSubviewsLayoutRelation 设置子视图之间间距的NSLayoutRelation值
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation;

/**
 *  设置约束  父视图
 *  @param  arrangementType             子视图排列的类型
 *  @param  marginInsets                子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距，可以在其中设置返回view的其它约束
 *  @param  setupSubviewsLayoutRelation 设置子视图之间间距的NSLayoutRelation值
 *  @param  setupSubviewLayoutRelation  设置子视图相对于父视图的NSLayoutRelation值
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(nullable CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation;

/**
 *  设置约束  视图控制器
 *  @param  viewController          视图控制器
 *  @param  arrangementType         子视图排列的类型
 *  @param  marginInsets            子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoViewController:(UIViewController *)viewController arrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

#pragma mark - 视图大小
/**
 *  设置宽高约束
 *  @param  dimension   视图的宽或高
 *  @param  fixedLength 设置宽或高的大小
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoDimension:(CGDimension)dimension fixedLength:(CGFloat)fixedLength;
/**
 *  设置宽高与指定视图相等的约束
 *  @param  dimension   视图的宽或高
 *  @param  equalView   指定视图
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoDimension:(CGDimension)dimension equalView:(UIView *)equalView;

@end

NS_ASSUME_NONNULL_END