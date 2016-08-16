//
//  CGWebPrivateView.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebPrivateView.h"
#import "CGWebView.h"

#import "UIView+CGAddConstraints.h"

#import "NSObject+CGDelaySelector.h"

@interface CGWebPrivateView ()
{
    BOOL didSetupConstraints;
    NSLayoutConstraint *_bottomViewBottomConstraint;
    NSLayoutConstraint *_bottomViewHeightConstraint;
}

@end

@implementation CGWebPrivateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bottomViewHeight   = 44;
        [self cg_performAfterZeroDelaySelector:@selector(reloadView)];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<CGWebPrivateViewDelegate>)delegate
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        
        _delegate   = delegate;
        
    }
    return self;
}

- (void)updateConstraints
{
    
    if (!didSetupConstraints) {
        
        [self.webView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:CGLayoutEdgeBottom];
        [self.webView cg_autoInverseAttribute:CGLayoutEdgeBottom toItem:self.bottomView];
        [self.bottomView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingOptionEdge:CGLayoutOptionEdgeHorizontal];
        _bottomViewBottomConstraint = [self.bottomView cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom];
        _bottomViewHeightConstraint = [self.bottomView cg_autoDimension:CGDimensionHeight fixedLength:[self getBottomViewHeight]];
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

- (CGFloat)getBottomViewHeight
{
    if ([self.delegate respondsToSelector:@selector(bottomViewHeightWithWebView:)]) {
        self.bottomViewHeight   = [self.delegate bottomViewHeightWithWebView:self];
    }
    return self.bottomViewHeight;
}

- (BOOL)hiddenBottomView
{
    if ([self.delegate respondsToSelector:@selector(shouldHiddenBottomViewWithWebView:)]) {
        self.isHiddenBottomView = [self.delegate shouldHiddenBottomViewWithWebView:self];
    }
    return self.isHiddenBottomView;
}

- (void)reloadView
{
    if (!_webView) {
        _webView    = [[CGWebView alloc] init];
    }
    if (!_webView.superview) {
        [self addSubview:_webView];
    }
    
    BOOL isUpdateBottomView = YES;
    if (self.bottomView) {
        if ([self.delegate respondsToSelector:@selector(shouldUpdateBottomViewWith:)]) {
            isUpdateBottomView  = [self.delegate shouldUpdateBottomViewWith:self];
        }
    }
    
    if (isUpdateBottomView && [self.delegate respondsToSelector:@selector(bottomViewWithWebView:)]) {
        UIView *bottomView  = [self.delegate bottomViewWithWebView:self];
        if (bottomView != self.bottomView) {
            if (self.bottomView.superview) {
                [self.bottomView removeFromSuperview];
            }
            self.bottomView = bottomView;
        }
    }
    
    if (!self.bottomView.superview) {
        [self addSubview:self.bottomView];
    }
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - 设置属性
- (void)setDelegate:(id<CGWebPrivateViewDelegate>)delegate
{
    if (_delegate != delegate) {
        _delegate   = delegate;
        [self cg_performAfterZeroDelaySelector:@selector(reloadView)];
    }
}

@end
