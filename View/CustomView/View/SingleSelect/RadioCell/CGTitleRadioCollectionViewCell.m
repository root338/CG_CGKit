//
//  CGTitleRadioCollectionViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleRadioCollectionViewCell.h"

#import "UIView+CGAddConstraints.h"
#import "UIView+CGAddConstraintStatus.h"

#import "CGTitleRadioCellAppearance.h"

@interface CGTitleRadioCollectionViewCell ()
{
    CGTitleRadioCellAppearance  *_appearance;
}
@property (nullable, nonatomic, strong, readwrite) UILabel *titleLabel;

@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;
@end

@implementation CGTitleRadioCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _marginEdgeInsets   = UIEdgeInsetsZero;
        _titleLabel = [[UILabel alloc] initWithFrame:frame];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel cg_autoEdgesInsetsZeroToSuperview];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setupTitleLabelColor];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setupTitleLabelColor];
}

- (void)setupTitleLabelColor
{
    UIColor *titleColor = nil;
    if (self.highlighted) {
        titleColor  = _appearance.titleHighlightedColor;
    }else if (self.selected) {
        titleColor  = _appearance.titleSelectedColor;
    }else {
        titleColor  = _appearance.titleNormalColor;
    }
    
    if (self.titleLabel.textColor != titleColor) {
        self.titleLabel.textColor   = titleColor;
    }
}

- (void)setupCollectionViewCellContentWithData:(CGTitleRadioCellAppearance *)appearance
{
    _appearance                 = appearance;
    
    self.marginEdgeInsets       = appearance.itemMarginEdgeInsets;
    self.titleLabel.font        = appearance.titleFont;
    [self setupTitleLabelColor];
}

#pragma mark - 设置属性
- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsets, _marginEdgeInsets)) {
        
        _marginEdgeInsets   = marginEdgeInsets;
        _titleLabel.isUpdateAddConstraint   = YES;
        [_titleLabel cg_autoEdgesToSuperviewEdgesWithInsets:marginEdgeInsets];
    }
}

@end
