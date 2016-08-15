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
}
@end

@implementation CGLayoutMarginBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self performSelector:@selector(delaySetupConstraints)
                   withObject:nil
                   afterDelay:0];
    }
    return self;
}

- (void)delaySetupConstraints
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.disableRunLoopSetupConstraints) {
        return;
    }
    [self setupConstraints];
}

- (void)setupConstraints
{
    UIView *targetView  = [self cg_layoutMarginTargetView];
    CGDebugAssert(targetView != self, @"目标视图不能为self自身");
    
    if (!targetView || targetView == self || !targetView.superview) {
        return;
    }
    
    [UIView cg_autoSetUpdate:didSetupConstraints forConstraints:^{
        [targetView cg_autoEdgesToSuperviewEdgesWithInsets:self.marginEdgeInsets];
    }];
    
    if (!didSetupConstraints) {
        
        didSetupConstraints         = YES;
    }
}

#pragma mark - CGLayoutMarginDelegate
- (UIView *)cg_layoutMarginTargetView
{
    return self;
}

#pragma mark - 设置属性

@end
