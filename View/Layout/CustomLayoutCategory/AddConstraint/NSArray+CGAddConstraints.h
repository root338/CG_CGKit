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

/** 设置子视图相对于父视图的边约束是否忽略 */
typedef BOOL (^CGSetupSubviewExculdingEdge) (UIView *view, CGLayoutEdge exculdingEdge);

@interface NSArray (CGAddViewSubviewsConstraints)

/** 子视图之间统一的间距 */
@property (nonatomic, assign) CGFloat subviewsSpaceValue;

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayout;
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayout;

- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayoutWithViewController:(UIViewController *)viewController;
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayoutWithViewController:(UIViewController *)viewController;

/**
 *  垂直铺展子视图 (设置子视图之间的间距)
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/**
 *  水平铺展子视图 (设置子视图之间的间距)
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/** 
 *  设置(铺展类型，外边距，忽略边)约束
 *  @param  arrangementType             子视图排列的类型
 *  @param  marginInsets                子视图相对于父视图的间距
 *  @param  setupSubviewExculdingEdge   需要忽略的与父视图的边
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewLayoutExculdingEdge:(nullable CGSetupSubviewExculdingEdge)setupSubviewExculdingEdge;

/** 
 *  设置(铺展类型，外边距，子视图间距)约束
 *  @param  arrangementType         子视图排列的类型
 *  @param  marginInsets            子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/**
 *  设置(铺展类型，外边距，子视图间的间距／约束类型)约束
 *  @param  arrangementType             子视图排列的类型
 *  @param  marginInsets                子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距，可以在其中设置返回view的其它约束
 *  @param  setupSubviewsLayoutRelation 设置子视图之间间距的NSLayoutRelation值
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoArrangementType:(CGSubviewsArrangementType)arrangementType marginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation;

/**
 *  设置(铺展类型，外边距，子视图间距，子视图间／与父视图的约束类型，)约束
 *  @param  arrangementType             子视图排列的类型
 *  @param  marginInsets                子视图相对于父视图的间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距，可以在其中设置返回view的其它约束
 *  @param  setupSubviewsLayoutRelation 设置子视图之间间距的NSLayoutRelation值
 *  @param  setupSubviewLayoutRelation  设置子视图相对于父视图的NSLayoutRelation值
 *  @param  setupSubviewsSpaceBlock 设置子视图之间的间距，可以在其中设置返回view的其它约束
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


#pragma mark - 视图对齐
/** 
 *  UIView与父视图之间的对齐
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoCenterToSuperviewWithAxis:(CGAxis)axis;
/** 
 *  UIView与指定视图之间的对齐
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoAxis:(CGAxis)axis toSameAxisOfView:(UIView *)otherView;

/** 
 *  UIView与指定view之间边对齐
 */
- (NSArray<NSLayoutConstraint *> *)cg_attribute:(NSLayoutAttribute)attribute toItem:(UIView *)view;

/**
 *  子视图水平排列，且与父视图的 X 对齐
 *  @param  marginInsets                设置边界间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距 为nil 间距值为subviewsSpaceValue
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/**
 *  子视图水平排列，且与父视图的 X 对齐
 *  @param  marginInsets                设置边界间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距 为nil 间距值为subviewsSpaceValue
 *  @param  setupSubviewsLayoutRelation 设置子视图之间间距的NSLayoutRelation值
 *  @param  setupSubviewLayoutRelation  设置子视图相对于父视图的NSLayoutRelation值
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(nullable CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation;

/**
 *  子视图垂直排列，且与父视图的 Y 对齐
 *  @param  marginInsets                设置边界间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距 为nil 间距值为subviewsSpaceValue
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayoutAxisVerticalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock;

/**
 *  子视图垂直排列，且与父视图的 Y 对齐
 *  @param  marginInsets                设置边界间距
 *  @param  setupSubviewsSpaceBlock     设置子视图之间的间距 为nil 间距值为subviewsSpaceValue
 *  @param  setupSubviewsLayoutRelation 设置子视图之间间距的NSLayoutRelation值
 *  @param  setupSubviewLayoutRelation  设置子视图相对于父视图的NSLayoutRelation值
 */
- (NSArray<NSLayoutConstraint *> *)cg_autoSetupVerticalSubviewsLayoutAxisVerticalWithMarginInsets:(UIEdgeInsets)marginInsets setupSubviewsSpace:(nullable CGSetupSubviewSpace)setupSubviewsSpaceBlock setupSubviewsLayoutRelation:(nullable CGSetupSubviewsLayoutRelation)setupSubviewsLayoutRelation setupSubviewLayoutRelation:(nullable CGSetupSubviewLayoutRelation)setupSubviewLayoutRelation;

@end

NS_ASSUME_NONNULL_END