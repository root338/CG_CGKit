//
//  CGTitleButtonsLayoutView.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleButtonsLayoutView.h"

#import "UIView+CGAddConstraints.h"

@interface CGTitleButtonsLayoutView ()

@property (nonatomic, strong, readwrite) UIButton *firstButton;

@property (nonatomic, strong, readwrite) UIButton *lastButton;

@end

@implementation CGTitleButtonsLayoutView

- (void)initialization
{
    self.firstButton    = [UIButton buttonWithType:UIButtonTypeSystem];
    self.lastButton     = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self addSubview:self.firstButton];
    [self addSubview:self.lastButton];
}

#pragma mark - 设置属性

- (void)setMinimumSpacing:(CGFloat)minimumSpacing
{
    if (_minimumSpacing != minimumSpacing) {
        _minimumSpacing = minimumSpacing;
    }
}

- (void)setFirstMarginEdgeInsets:(UIEdgeInsets)firstMarginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_firstMarginEdgeInsets, firstMarginEdgeInsets)) {
        _firstMarginEdgeInsets  = firstMarginEdgeInsets;
        
    }
}

- (void)setLastMarginEdgeInsets:(UIEdgeInsets)lastMarginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_lastMarginEdgeInsets, lastMarginEdgeInsets)) {
        _lastMarginEdgeInsets   = lastMarginEdgeInsets;
        
    }
}

@end
