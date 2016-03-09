//
//  CGTitleButtonContentView.m
//  QuickAskCommunity
//
//  Created by DY on 16/2/17.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleButtonContentView.h"
#import "CGButton.h"

#import "UIView+CG_CGAreaCalculate.h"

@interface CGTitleButtonContentView ()
{
    
}

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) CGButton *titleButton;

@end

@implementation CGTitleButtonContentView

- (void)initialization
{
    _titleLabelVerticalCenter   = YES;
    _titleButtonVerticalCenter  = YES;
    
    self.titleLabel.superview   ?:  [self addSubview:self.titleLabel];
    self.titleButton.superview  ?:  [self addSubview:self.titleButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (CGSizeEqualToSize(self.titleLabelMaxSize, CGSizeZero)) {
        [self.titleLabel sizeToFit];
    }else {
        CGSize labelSize    = [self.titleLabel sizeThatFits:self.titleLabelMaxSize];
        self.titleLabel.size   = labelSize;
    }
    
    CGFloat originY;
    if (self.titleLabelVerticalCenter) {
        
        originY = (self.height - self.titleLabel.height) / 2;
    }else {
        
        originY = self.titleLabelMarginEdgeInsets.top;
        self.titleLabel.height  = CG_CGHeightWithMaxHeight(self.height, self.titleLabelMarginEdgeInsets);
    }
    
    self.titleLabel.origin      = CGPointMake(self.titleLabelMarginEdgeInsets.left, originY);
    
    [self.titleButton sizeToFit];
    
    if (!CGSizeEqualToSize(self.titleButtonMaxSize, CGSizeZero)) {
        
        CGSize buttonSize       = CG_CGMinSize(self.titleButton.size, self.titleButtonMaxSize);
        self.titleButton.size   = buttonSize;
    }
    
    CGFloat originXForTitleButton;
    CGFloat originYForTitleButton;
    if (self.cancelJustified) {
        
    }else {
        originXForTitleButton   = self.width - (self.titleButton.width + self.titleButtonMarginEdgeInsets.right);
    }
    if (self.titleButtonVerticalCenter) {
        
        originYForTitleButton   = (self.height - self.titleButton.height) / 2;
    }else {
        
        self.titleButton.height = CG_CGHeightWithMaxHeight(self.height, self.titleButtonMarginEdgeInsets);
        originYForTitleButton   = self.titleButtonMarginEdgeInsets.top;
    }
    self.titleButton.origin     = CGPointMake(originXForTitleButton, originYForTitleButton);
    
    if (self.titleLabel.maxX > self.titleButton.xOrigin - self.space) {
        self.titleLabel.width   = self.titleButton.xOrigin - self.titleLabelMarginEdgeInsets.left - self.space;
    }else {
        if (self.cancelJustified) {
            self.titleButton.xOrigin    = self.titleLabel.maxX + self.space;
        }
    }
}

- (BOOL)judgeVerticalCenterWithEdgeInsets:(UIEdgeInsets)paramEdgeInsets
{
    if (paramEdgeInsets.top != 0 || paramEdgeInsets.bottom != 0) {
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - 设置属性

- (UILabel *)titleLabel
{
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    return _titleLabel;
}

- (CGButton *)titleButton
{
    if (_titleButton) {
        return _titleButton;
    }
    
    _titleButton = [CGButton buttonWithType:UIButtonTypeSystem];
    return _titleButton;
}

- (void)setTitleLabelMarginEdgeInsets:(UIEdgeInsets)titleLabelMarginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_titleLabelMarginEdgeInsets, titleLabelMarginEdgeInsets)) {
        _titleLabelMarginEdgeInsets     = titleLabelMarginEdgeInsets;
        self.titleLabelVerticalCenter   = [self judgeVerticalCenterWithEdgeInsets:titleLabelMarginEdgeInsets];
    }
}

- (void)setTitleButtonMarginEdgeInsets:(UIEdgeInsets)titleButtonMarginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_titleButtonMarginEdgeInsets, titleButtonMarginEdgeInsets)) {
        _titleButtonMarginEdgeInsets    = titleButtonMarginEdgeInsets;
        self.titleButtonVerticalCenter  = [self judgeVerticalCenterWithEdgeInsets:titleButtonMarginEdgeInsets];
    }
}

@end
