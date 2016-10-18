//
//  CGTitleImageLayoutView.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleImageLayoutView.h"
#import "CGMultilineLabel.h"

@interface CGTitleImageLayoutView ()
{
    
}

@property (nonatomic, strong, readwrite) UIImageView        * imageView;

@property (nonatomic, strong, readwrite) CGMultilineLabel   * titleLabel;

@end

@implementation CGTitleImageLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializationData];
    }
    return self;
}

- (void)awakeFromNib
{
    [self initializationData];
    [super awakeFromNib];
}

- (void)initializationData
{
    _imageView  = [[UIImageView alloc] init];
    _titleLabel = [[CGMultilineLabel alloc] init];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_imageView];
}

#pragma mark - CGDoubleLayoutDelegate
- (UIView *)cg_layoutFirstTargetView
{
    return self.firstItemIsTitleLabel ? self.titleLabel : self.imageView;
}

- (UIView *)cg_layoutSecondTargetView
{
    return self.firstItemIsTitleLabel ? self.imageView : self.titleLabel;
}

@end
