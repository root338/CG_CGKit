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

@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation CGTitleLabelayoutView

- (instancetype)initWithMarginEdgeInstes:(UIEdgeInsets)marginEdgeInstes
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setMarginEdgeInsets:marginEdgeInstes];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self   = [super initWithFrame:frame];
    if (self) {
        
        _label  = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.label.preferredMaxLayoutWidth = CG_CGWidthWithMaxWidth(CGRectGetWidth(bounds), self.marginEdgeInsets);
}

@end
