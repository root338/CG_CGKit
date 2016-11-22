//
//  CGBaseSelectorView.m
//  TestCG_CGKit
//
//  Created by DY on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseSelectorView.h"

#import "CGPrintLogHeader.h"

@interface CGBaseSelectorView ()
{
    UIButton *cancelButton;
}

@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation CGBaseSelectorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentView    = [[UIView alloc] init];
        
        _frameEqualSuperviewBounds          = YES;
        _didHideContentViewRemoveSuperview  = YES;
        _disableBackgroundButtonTools       = NO;
    }
    return self;
}

- (void)show
{
    [self setupSelfContent];
    [self setupCancelButton];
    [self setupContentView];
}

- (void)hide
{
    
}

#pragma mark - 处理事件
- (void)handleCancelAction:(id)sender
{
    if (self.disableBackgroundButtonTools) {
        return;
    }
    [self hide];
}

#pragma mark - 设置视图
- (void)setupSelfContent
{
    if (self.superview == nil) {
        UIView *targetSuperview = nil;
        if (self.setupSuperviewBlock) {
            targetSuperview = self.setupSuperviewBlock();
        }else {
            targetSuperview = self.targetSuperview;
        }
        CGDebugAssert(targetSuperview, @"请设置选择视图的父视图");
        [targetSuperview addSubview:self];
        if (self.frameEqualSuperviewBounds) {
            self.frame  = targetSuperview.bounds;
        }
    }
}

- (void)setupCancelButton
{
    if (self.disableBackgroundButtonTools) {
        if (cancelButton != nil) {
            [cancelButton removeFromSuperview];
        }
    }else{
        if (cancelButton == nil) {
            cancelButton    = [UIButton buttonWithType:UIButtonTypeCustom];
            [cancelButton addTarget:self action:@selector(handleCancelAction:) forControlEvents:UIControlEventTouchUpInside];
            cancelButton.frame  = self.bounds;
        }
        if (cancelButton.superview == nil) {
            [self addSubview:cancelButton];
        }
        [self sendSubviewToBack:cancelButton];
    }
}

- (void)setupContentView
{
    if (self.contentView.superview == nil) {
        [self addSubview:self.contentView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    cancelButton.frame  = self.bounds;
}

@end
