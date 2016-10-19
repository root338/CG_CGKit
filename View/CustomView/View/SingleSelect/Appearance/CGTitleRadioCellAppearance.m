//
//  CGTitleRadioCellAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioCellAppearance.h"

@interface CGTitleRadioCellAppearance ()

@property (nullable, nonatomic, strong, readwrite) UIColor         *   titleNormalColor;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   titleSelectedColor;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   titleHighlightedColor;
@property (nullable, nonatomic, strong, readwrite) UIFont          *   titleFont;

@property (nonatomic, assign, readwrite)           UIEdgeInsets        itemMarginEdgeInsets;

@property (nullable, nonatomic, strong, readwrite) UIColor         *   itemBackgroundColor;
@property (nullable, nonatomic, strong, readwrite) UIColor         *   itemSelectedBackgroundColor;

@property (nullable, nonatomic, strong, readwrite) UIView          *   itemBackgroundView;
@property (nullable, nonatomic, strong, readwrite) UIView          *   itemSelectedBackgroundView;

@end

@implementation CGTitleRadioCellAppearance

@end

@implementation CGMutableTitleRadioCellAppearance

@dynamic titleNormalColor;
@dynamic titleSelectedColor;
@dynamic titleHighlightedColor;
@dynamic titleFont;
@dynamic itemMarginEdgeInsets;
@dynamic itemBackgroundColor;
@dynamic itemBackgroundView;
@dynamic itemSelectedBackgroundColor;
@dynamic itemSelectedBackgroundView;

@end
