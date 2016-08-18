//
//  CGWebPrivateViewConstraintsManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebPrivateViewConstraintsManager.h"

#import "CGWebView.h"
#import "CGWebPrivateView.h"

#import "UIView+CGAddConstraints.h"

#import "Value+Constant.h"

@interface CGWebPrivateViewConstraintsManager ()
{
    BOOL didSetupConstraints;
    
    __weak NSLayoutConstraint *_bottomViewBottomConstraint;
    __weak NSLayoutConstraint *_bottomViewHeightConstraint;
    __weak NSLayoutConstraint *_progressViewHeightConstraint;
}

@property (nonatomic, weak, readwrite) CGWebPrivateView *view;
@end

@implementation CGWebPrivateViewConstraintsManager

- (instancetype)initWithView:(CGWebPrivateView *)view
{
    self = [super init];
    if (self) {
        _view   = view;
    }
    return self;
}

- (void)updateConstraints
{
    didSetupConstraints = NO;
    [self constraintsWithUpdate:YES];
}

- (void)setupConstraints
{
    [self constraintsWithUpdate:NO];
}

- (void)constraintsWithUpdate:(BOOL)isUpdate
{
    if (!didSetupConstraints) {
        
        [UIView cg_autoSetUpdate:isUpdate forConstraints:^{
            
            [self setupHeightWithType:CGWebPrivateViewTypeBottomViewHeight];
            [self setupHeightWithType:CGWebPrivateViewTypeProgressViewHeight];
            [self.view.progressView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:CGLayoutEdgeBottom];
            [self.view.webView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:CGLayoutEdgeBottom];
            [self.view.webView cg_autoInverseAttribute:CGLayoutEdgeBottom toItem:self.view.bottomView];
            [self.view.bottomView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingOptionEdge:CGLayoutOptionEdgeHorizontal];
            _bottomViewBottomConstraint = [self.view.bottomView cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom];
            
        }];
        
        didSetupConstraints = YES;
    }
}

- (BOOL)hiddenBottomView
{
    if ([self.view.delegate respondsToSelector:@selector(shouldHiddenBottomViewWithWebView:)]) {
        self.view.isHiddenBottomView = [self.view.delegate shouldHiddenBottomViewWithWebView:self.view];
    }
    return self.view.isHiddenBottomView;
}

- (NSLayoutConstraint *)setupHeightWithType:(CGWebPrivateViewType)type
{
    CGFloat height  = 0;
    NSLayoutConstraint *layotConstraint = nil;
    if (type == CGWebPrivateViewTypeBottomViewHeight) {
        height  = self.view.bottomViewHeight;
        if ([self.view.delegate respondsToSelector:@selector(bottomViewHeightWithWebView:)]) {
            height  = [self.view.delegate bottomViewHeightWithWebView:self.view];
        }
        layotConstraint = _bottomViewHeightConstraint;
    }
    if (type == CGWebPrivateViewTypeProgressViewHeight) {
        height  = self.view.progressViewHeight;
        if ([self.view.delegate respondsToSelector:@selector(progressViewHeightWithWebView:)]) {
            height  = [self.view.delegate progressViewHeightWithWebView:self.view];
        }
        layotConstraint = _progressViewHeightConstraint;
    }
    if (height < CGZeroFloatValue && !layotConstraint) {
        return nil;
    }
    
    if (layotConstraint) {
        layotConstraint.constant    = height;
    }else {
        if (type == CGWebPrivateViewTypeBottomViewHeight) {
            _bottomViewHeightConstraint = [self.view.bottomView cg_autoDimension:CGDimensionHeight fixedLength:height];
            layotConstraint             = _bottomViewHeightConstraint;
        }else if (type == CGWebPrivateViewTypeProgressViewHeight) {
            
            _progressViewHeightConstraint   = [self.view.progressView cg_autoDimension:CGDimensionHeight fixedLength:height];
            layotConstraint                 = _progressViewHeightConstraint;
        }
    }
    return layotConstraint;
}

- (void)bottomViewIsHidden:(BOOL)isHidden animated:(BOOL)animated
{
    if (!_bottomViewBottomConstraint) {
        return;
    }
    
    if (isHidden) {
        _bottomViewBottomConstraint.constant    = self.view.bottomView.height;
    }else {
        _bottomViewBottomConstraint.constant    = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.view.bottomView.hidden = isHidden;
    }];
}

- (void)setupViewHeight:(CGFloat)height type:(CGWebPrivateViewType)type animated:(BOOL)animated
{
    if (!(type == CGWebPrivateViewTypeBottomViewHeight || type == CGWebPrivateViewTypeProgressViewHeight)) {
        return;
    }
    
    if (type == CGWebPrivateViewTypeBottomViewHeight) {
        if (!self.view.bottomView.superview) {
            return;
        }
        if (self.view.bottomView.hidden) {
            animated    = NO;
        }
    }
    if (type == CGWebPrivateViewTypeProgressViewHeight) {
        if (!self.view.progressView.superview) {
            return;
        }
        if (self.view.progressView.hidden) {
            animated    = NO;
        }
    }
    
    [self setupHeightWithType:type];
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else {
        [self.view layoutIfNeeded];
    }
}

@end
