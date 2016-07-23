//
//  CGTitleLabelayoutView.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleLabelayoutView.h"

#import "UIView+CG_CGAreaCalculate.h"

@interface CGTitleLabelayoutView ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation CGTitleLabelayoutView

- (instancetype)initWithMarginEdgeInstes:(UIEdgeInsets)marginEdgeInstes
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self setMarginEdgeInsets:marginEdgeInstes];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self   = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel  = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
    }
    return self;
}

#pragma mark - CGLayoutMarginDelegate
- (UIView *)cg_layoutMarginTargetView
{
    return self.titleLabel;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.titleLabel.preferredMaxLayoutWidth = CG_CGWidthWithMaxWidth(CGRectGetWidth(bounds), self.marginEdgeInsets);
}

@end
