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

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    CGTitleRadioCellAppearance *cellAppearance  = [[[self class] alloc] init];
    [self copyWithAppearance:cellAppearance];
    return cellAppearance;
}

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone
{
    CGMutableTitleRadioCellAppearance *cellAppearance   = [[CGMutableTitleRadioCellAppearance alloc] init];
    [self copyWithAppearance:cellAppearance];
    return cellAppearance;
}

- (void)copyWithAppearance:(CGTitleRadioCellAppearance *)cellAppearance
{
    cellAppearance.titleNormalColor             = [self.titleNormalColor copy];
    cellAppearance.titleSelectedColor           = [self.titleSelectedColor copy];
    cellAppearance.titleHighlightedColor        = [self.titleHighlightedColor copy];
    cellAppearance.titleFont                    = [self.titleFont copy];
    cellAppearance.itemMarginEdgeInsets         = self.itemMarginEdgeInsets;
    cellAppearance.itemBackgroundColor          = [self.itemBackgroundColor copy];
    cellAppearance.itemBackgroundView           = self.itemBackgroundView;
    cellAppearance.itemSelectedBackgroundColor  = [self.itemSelectedBackgroundColor copy];
    cellAppearance.itemSelectedBackgroundView   = self.itemSelectedBackgroundView;
    cellAppearance.separatorColor               = [self.separatorColor copy];
    cellAppearance.separatorStyle               = self.separatorStyle;
    cellAppearance.separatorEdgeInsets          = self.separatorEdgeInsets;
    cellAppearance.separatorHeight              = self.separatorHeight;
    cellAppearance.separatorIgnoreType          = self.separatorIgnoreType;
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
