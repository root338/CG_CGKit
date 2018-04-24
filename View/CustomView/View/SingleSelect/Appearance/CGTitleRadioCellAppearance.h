//
//  CGTitleRadioCellAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/** cell 分隔线的类型 */
typedef NS_ENUM(NSInteger, CGCellSeparatorStyle) {
    /** 没有分隔线 */
    CGCellSeparatorStyleNone,
    /** 单线 */
    CGCellSeparatorStyleLine,
};

/** cell 添加分隔线需要忽略的cell */
typedef NS_OPTIONS(NSInteger, CGCellSeparatorIgnoreType) {
    /** 第一个cell */
    CGCellSeparatorIgnoreTypeFirstCell  = 1 << 0,
    /** 最后一个cell */
    CGCellSeparatorIgnoreTypeLastCell   = 1 << 1,
};

/** 标题视图单元外观 */
@interface CGTitleRadioCellAppearance : CGBaseObject<NSCopying, NSMutableCopying>

//内部选择按钮设置
@property (nullable, nonatomic, strong, readonly) UIColor *titleNormalColor;
@property (nullable, nonatomic, strong, readonly) UIColor *titleSelectedColor;
@property (nullable, nonatomic, strong, readonly) UIColor *titleHighlightedColor;
@property (nullable, nonatomic, strong, readonly) UIFont  *titleFont;

@property (nonatomic, assign, readonly) UIEdgeInsets itemMarginEdgeInsets;

@property (nullable, nonatomic, strong, readonly) UIColor *itemBackgroundColor;
@property (nullable, nonatomic, strong, readonly) UIColor *itemSelectedBackgroundColor;

@property (nullable, nonatomic, strong, readonly) UIView *itemBackgroundView;
@property (nullable, nonatomic, strong, readonly) UIView *itemSelectedBackgroundView;

/** 分隔线，默认为CGCellSeparatorStyleNone */
@property (nonatomic, assign, readonly) CGCellSeparatorStyle separatorStyle;
@property (nullable, nonatomic, strong, readonly) UIColor *separatorColor;
/** 分隔线与视图的间距，忽略 top 值 */
@property (nonatomic, assign, readonly) UIEdgeInsets separatorEdgeInsets;
/** 分隔线的高度，默认 UIScreen scale 值 */
@property (nonatomic, assign, readonly) CGFloat separatorHeight;
@property (nonatomic, assign, readonly) CGCellSeparatorIgnoreType separatorIgnoreType;
@end

@interface CGMutableTitleRadioCellAppearance : CGTitleRadioCellAppearance

@property (nullable, nonatomic) UIColor *titleNormalColor;
@property (nullable, nonatomic) UIColor *titleSelectedColor;
@property (nullable, nonatomic) UIColor *titleHighlightedColor;
@property (nullable, nonatomic) UIFont *titleFont;

@property (nonatomic) UIEdgeInsets itemMarginEdgeInsets;

@property (nullable, nonatomic) UIColor *itemBackgroundColor;
@property (nullable, nonatomic) UIColor *itemSelectedBackgroundColor;

@property (nullable, nonatomic) UIView *itemBackgroundView;
@property (nullable, nonatomic) UIView *itemSelectedBackgroundView;

@property (nonatomic) CGCellSeparatorStyle separatorStyle;
@property (nullable, nonatomic) UIColor *separatorColor;
@property (nonatomic) UIEdgeInsets separatorEdgeInsets;
@property (nonatomic) CGFloat separatorHeight;
@property (nonatomic) CGCellSeparatorIgnoreType separatorIgnoreType;
@end

NS_ASSUME_NONNULL_END
