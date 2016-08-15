//
//  CGTitleLabelLayoutView.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleLabelLayoutView.h"

#import "UIView+CG_CGAreaCalculate.h"

@interface CGTitleLabelLayoutView ()

@property (nonatomic, strong, readwrite) CGMultilineLabel *titleLabel;

@end

@implementation CGTitleLabelLayoutView

- (instancetype)initWithMarginEdgeInstes:(UIEdgeInsets)marginEdgeInstes
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self   = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel  = [[CGMultilineLabel alloc] init];
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
