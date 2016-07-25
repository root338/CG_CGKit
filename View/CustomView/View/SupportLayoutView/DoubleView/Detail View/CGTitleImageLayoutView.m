//
//  CGTitleImageLayoutView.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleImageLayoutView.h"

@interface CGTitleImageLayoutView ()

@property (nonatomic, strong, readwrite) UIImageView * imageView;

@property (nonatomic, strong, readwrite) UILabel     * titleLabel;

@end

@implementation CGTitleImageLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView  = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

#pragma mark - CGDoubleLayoutDelegate
- (UIView *)cg_layoutFirstTargetView
{
    return self.firstItemIsImageView ? self.imageView : self.titleLabel;
}

- (UIView *)cg_layoutSecondTargetView
{
    return self.firstItemIsImageView ? self.titleLabel : self.imageView;
}

@end
