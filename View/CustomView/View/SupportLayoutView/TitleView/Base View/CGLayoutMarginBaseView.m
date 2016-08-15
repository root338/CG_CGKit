//
//  CGLayoutMarginBaseView.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGLayoutMarginBaseView.h"

#import "UIView+CGAddConstraints.h"

#import "CGPrintLogHeader.h"

@interface CGLayoutMarginBaseView ()
{
    BOOL didSetupConstraints;
    //首次添加约束后，标识为YES，之后更新约束
    BOOL isUpdateConstraints;
}
@end

@implementation CGLayoutMarginBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        [self setupConstraints];
        didSetupConstraints         = YES;
    }
    [super updateConstraints];
}

- (void)setupConstraints
{
    UIView *targetView  = [self cg_layoutMarginTargetView];
    CGDebugAssert(targetView != self, @"目标视图不能为self自身");
    
    if (!targetView || targetView == self || !targetView.superview) {
        return;
    }
    
    [UIView cg_autoSetUpdate:isUpdateConstraints forConstraints:^{
        [targetView cg_autoEdgesToSuperviewEdgesWithInsets:self.marginEdgeInsets];
    }];
    
    if (!isUpdateConstraints) {
        isUpdateConstraints = YES;
    }
}

#pragma mark - CGLayoutMarginDelegate
- (UIView *)cg_layoutMarginTargetView
{
    return self;
}

#pragma mark - 设置属性
- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsets, _marginEdgeInsets)) {
        
        _marginEdgeInsets   = marginEdgeInsets;
        didSetupConstraints = NO;
        
        [self setNeedsUpdateConstraints];
    }
}
@end
