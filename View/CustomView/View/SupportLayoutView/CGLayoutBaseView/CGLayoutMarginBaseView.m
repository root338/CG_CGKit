//
//  CGLayoutMarginBaseView.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGLayoutMarginBaseView.h"

#import "UIView+CGAddConstraints.h"

@interface CGLayoutMarginBaseView ()
{
    BOOL didSetupConstraints;
}
@end

@implementation CGLayoutMarginBaseView

- (void)setupConstraints
{
    UIView *targetView  = [self cg_layoutMarginTargetView];
    if (!targetView || targetView == self || !targetView.superview) {
        return;
    }
    
    if (didSetupConstraints) {
        targetView.isUpdateAddConstraint  = YES;
    }else {
        didSetupConstraints         = YES;
    }
    
    [targetView cg_autoEdgesToSuperviewEdgesWithInsets:self.marginEdgeInsets];
}

#pragma mark - CGLayoutMarginDelegate
- (UIView *)cg_layoutMarginTargetView
{
    return self;
}

#pragma mark - 设置属性
- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_marginEdgeInsets, marginEdgeInsets)) {
        
        _marginEdgeInsets   = marginEdgeInsets;
        [self setupConstraints];
    }
}

@end
