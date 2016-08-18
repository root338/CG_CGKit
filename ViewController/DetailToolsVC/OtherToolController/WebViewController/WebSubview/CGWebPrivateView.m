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

#import "CGWebPrivateViewConstraintsManager.h"

#import "NSObject+CGDelaySelector.h"
#import "CGWebPrivateViewTypeHeader.h"

@interface CGWebPrivateView ()
{
    BOOL isUpdateConstraints;
    CGWebPrivateViewConstraintsManager  *_constraintsManager;
}

@end

@implementation CGWebPrivateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bottomViewHeight   = 44;
        _constraintsManager = [[CGWebPrivateViewConstraintsManager alloc] initWithView:self];
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
    if (isUpdateConstraints) {
        [_constraintsManager updateConstraints];
    }else {
        [_constraintsManager setupConstraints];
    }
    [super updateConstraints];
}

- (void)reloadView
{
    isUpdateConstraints    = NO;
    
    if (!_webView) {
        _webView    = [[CGWebView alloc] init];
    }
    if (!_webView.superview) {
        [self addSubview:_webView];
        isUpdateConstraints = YES;
    }
    
    BOOL isUpdateBottomView = YES;
    if (self.bottomView) {
        if ([self.delegate respondsToSelector:@selector(shouldUpdateBottomViewWithWebView:)]) {
            isUpdateBottomView  = [self.delegate shouldUpdateBottomViewWithWebView:self];
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
        isUpdateConstraints = YES;
    }
    
    BOOL isUpdateProgressView   = YES;
    if (self.progressView) {
        if ([self.delegate respondsToSelector:@selector(shouldUpdateProgressViewWithWebView:)]) {
            isUpdateProgressView = [self.delegate shouldUpdateProgressViewWithWebView:self];
        }
    }
    if (isUpdateProgressView && [self.delegate respondsToSelector:@selector(progressViewWithWebView:)]) {
        UIView *progressView    = [self.delegate progressViewWithWebView:self];
        if (progressView != self.progressView) {
            if (self.progressView.superview) {
                [self.progressView removeFromSuperview];
            }
            self.progressView   = progressView;
        }
    }
    if (!self.progressView.superview) {
        [self addSubview:self.progressView];
        isUpdateConstraints = YES;
    }else {
        [self bringSubviewToFront:self.progressView];
    }
    
    if (isUpdateConstraints) {
        
        [self setNeedsUpdateConstraints];
    }
}

#pragma mark - 设置属性
- (void)setDelegate:(id<CGWebPrivateViewDelegate>)delegate
{
    if (_delegate != delegate) {
        _delegate   = delegate;
        [self cg_performAfterZeroDelaySelector:@selector(reloadView)];
    }
}

- (void)setIsHiddenBottomView:(BOOL)isHiddenBottomView
{
    if (_isHiddenBottomView != isHiddenBottomView) {
        
        _isHiddenBottomView = isHiddenBottomView;
        BOOL animated       = self.animatedChangeViewStatus;
        if ([self.delegate respondsToSelector:@selector(shouldAnimatedChangeBottomHiddenWithWebView:)]) {
            animated    = [self.delegate shouldAnimatedChangeBottomHiddenWithWebView:self];
        }
        [_constraintsManager bottomViewIsHidden:isHiddenBottomView animated:animated];
    }
}

- (void)setBottomViewHeight:(CGFloat)bottomViewHeight
{
    if (_bottomViewHeight != bottomViewHeight) {
        
        _bottomViewHeight   = bottomViewHeight;
        
        _bottomViewHeight   = bottomViewHeight;
        BOOL animated       = self.animatedChangeViewStatus;
        if ([self.delegate respondsToSelector:@selector(shouldAnimatedChangeBottomHeightWithWebView:)]) {
            animated    = [self.delegate shouldAnimatedChangeBottomHeightWithWebView:self];
        }
        [_constraintsManager setupBottomViewHeight:bottomViewHeight animated:animated];
    }
}

- (void)setProgressViewHeight:(CGFloat)progressViewHeight
{
    
}

@end
