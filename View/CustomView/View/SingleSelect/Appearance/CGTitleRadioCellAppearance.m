//
//  CGTitleRadioCellAppearance.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioCellAppearance.h"

#import "UIView+Constant.h"

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

@property (nonatomic, assign, readwrite)           CGCellSeparatorStyle  separatorStyle;
@property (nullable, nonatomic, strong, readwrite) UIColor         *     separatorColor;
@property (nonatomic, assign, readwrite)           UIEdgeInsets          separatorEdgeInsets;
@property (nonatomic, assign, readwrite)           CGFloat               separatorHeight;
@property (nonatomic, assign, readwrite) CGCellSeparatorIgnoreType       separatorIgnoreType;
@end

@implementation CGTitleRadioCellAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        _separatorStyle     = CGCellSeparatorStyleNone;
        _separatorHeight    = [UIView onePixlesForCGKitUIScreenScale];
    }
    return self;
}

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
@dynamic separatorColor;
@dynamic separatorStyle;
@dynamic separatorEdgeInsets;
@dynamic separatorHeight;
@dynamic separatorIgnoreType;

@end
