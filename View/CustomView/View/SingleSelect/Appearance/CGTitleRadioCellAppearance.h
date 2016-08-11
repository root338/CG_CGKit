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
@property (nullable, nonatomic, strong) UIColor         *   titleNormalColor;
@property (nullable, nonatomic, strong) UIColor         *   titleSelectedColor;
@property (nullable, nonatomic, strong) UIColor         *   titleHighlightedColor;
@property (nullable, nonatomic, strong) UIFont          *   titleFont;

@property (nonatomic, assign)           UIEdgeInsets        itemMarginEdgeInsets;

@property (nullable, nonatomic, strong) UIColor         *   itemBackgroundColor;
@property (nullable, nonatomic, strong) UIColor         *   itemSelectedBackgroundColor;

@property (nullable, nonatomic, strong) UIView          *   itemBackgourndView;
@property (nullable, nonatomic, strong) UIView          *   itemSelectedBackgroundView;

@end

NS_ASSUME_NONNULL_END