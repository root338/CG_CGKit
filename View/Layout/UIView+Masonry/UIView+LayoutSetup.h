//
//  UIView+LayoutSetup.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/31.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LayoutSetupHeader.h"

/**
 *  对视图内部所有子视图进行相同设置
 *  @warning 必须加入 Masonry 库 gitHub.com 地址 https://github.com/desandro/masonry
 */
@interface UIView (LayoutSetup)

#pragma mark - 设置内部子视图约束
/**
 *  设置视图内部视图的布局类型
 *
 *  @param type 布局类型值
 */
- (void)setupConstraintsWithType:(CGViewLayoutType)type;

/**
 *  设置视图内部视图的布局类型
 *
 *  @param type  布局类型值
 *  @param space 间距值
 */
- (void)setupConstraintsWithType:(CGViewLayoutType)type space:(CGFloat)space;

///**
// *  子视图的水平间距
// *
// *  @param space 间距值
// */
//- (void)setupSubviewConstraintsWithHorizontalSpace:(CGFloat)space;
//
///**
// *  子视图的垂直间距
// *
// *  @param space 间距值
// */
//- (void)setupSubviewConstraintsWithVerticalSpace:(CGFloat)space;

/**
 *  设置子视图的间距
 *
 *  @param marginSpace  视图距离外边框的距离
 *  @param type         类型值
 *  @param subviewSpace 间距值
 */
- (void)setupMarginSpace:(UIEdgeInsets)marginSpace type:(CGLayoutType)type subviewSpace:(CGFloat)subviewSpace;

#pragma mark - 设置视图与其父视图之间的约束
/**
 *  设置视图与父视图的约束关系
 *
 *  @param edgeInset 边距
 *  @param type      约束类型
 */
- (void)setupMarginToSuperViewAtEdgeInset:(UIEdgeInsets)edgeInset type:(CGLayoutForSuperViewType)type;

/**
 *  设置视图与父视图的约束关系
 *
 *  @param edgeInset      边距
 *  @param type           约束类型
 *  @param layoutRelation 边距的样式
 */
//- (void)setupMarginToSuperViewAtEdgeInset:(UIEdgeInsets)edgeInset type:(CGLayoutForSuperViewType)type layoutRelation:(NSLayoutRelation)layoutRelation;

#pragma mark - 设置视图与指定视图之间的约束

/**
 *  设置视图与指定视图之间的约束
 *  @warning 两视图之间必须拥有共同的父视图，attribute为接受消息视图的属性（如：attribute为 NSLayoutAttributeTop，那就相对于指定视图的NSLayoutAttributeBottom之间的约束）
 *
 *  @param view      指定视图
 *  @param attribute 设置的约束
 *  @param space     相对距离
 */
- (void)marginToView:(UIView *)view layoutAttribute:(NSLayoutAttribute)attribute space:(CGFloat)space;

#pragma mark - 设置视图自身的约束

/** 设置视图固定大小 */
- (void)setupSize:(CGSize)size;

/** 设置视图固定宽度 */
- (void)setupSizeAtWidth:(CGFloat)width;

/** 设置视图固定高度 */
- (void)setupSizeAtHeight:(CGFloat)height;
@end
