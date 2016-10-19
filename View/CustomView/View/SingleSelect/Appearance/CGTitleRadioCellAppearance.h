//
//  CGTitleRadioCellAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/** 标题视图单元外观 */
@interface CGTitleRadioCellAppearance : CGBaseObject

//内部选择按钮设置
@property (nullable, nonatomic, strong, readonly) UIColor         *   titleNormalColor;
@property (nullable, nonatomic, strong, readonly) UIColor         *   titleSelectedColor;
@property (nullable, nonatomic, strong, readonly) UIColor         *   titleHighlightedColor;
@property (nullable, nonatomic, strong, readonly) UIFont          *   titleFont;

@property (nonatomic, assign, readonly)           UIEdgeInsets        itemMarginEdgeInsets;

@property (nullable, nonatomic, strong, readonly) UIColor         *   itemBackgroundColor;
@property (nullable, nonatomic, strong, readonly) UIColor         *   itemSelectedBackgroundColor;

@property (nullable, nonatomic, strong, readonly) UIView          *   itemBackgroundView;
@property (nullable, nonatomic, strong, readonly) UIView          *   itemSelectedBackgroundView;

@end

@interface CGMutableTitleRadioCellAppearance : CGTitleRadioCellAppearance

@property (nullable, nonatomic) UIColor         *   titleNormalColor;
@property (nullable, nonatomic) UIColor         *   titleSelectedColor;
@property (nullable, nonatomic) UIColor         *   titleHighlightedColor;
@property (nullable, nonatomic) UIFont          *   titleFont;

@property (nonatomic)           UIEdgeInsets        itemMarginEdgeInsets;

@property (nullable, nonatomic) UIColor         *   itemBackgroundColor;
@property (nullable, nonatomic) UIColor         *   itemSelectedBackgroundColor;

@property (nullable, nonatomic) UIView          *   itemBackgroundView;
@property (nullable, nonatomic) UIView          *   itemSelectedBackgroundView;

@end

NS_ASSUME_NONNULL_END
