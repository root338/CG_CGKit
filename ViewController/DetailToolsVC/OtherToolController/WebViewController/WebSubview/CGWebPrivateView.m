//
//  CGWebPrivateView.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebPrivateView.h"
#import "CGWebView.h"
#import "CGWebViewToolBar.h"

#import "UIView+CGAddConstraints.h"
#import "NSArray+CGAddConstraints.h"

@interface CGWebPrivateView ()
{
    __weak NSLayoutConstraint *_bottomViewHeightConstraint;
    //底部视图顶部与父视图的约束
    __weak NSLayoutConstraint *_bottomViewTopConstraint;
}

@property (nonatomic, strong, readwrite) CGWebView          * webView;
@property (nonatomic, strong, readwrite) CGWebViewToolBar   * webViewToolBar;

@end

@implementation CGWebPrivateView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    CGWebView *webView  = [[CGWebView alloc] initWithWebViewType:CGWebViewTypeAuto];
    
    NSArray<NSNumber *> *itemsType  = @[
                                        @(CGWebViewItemTypeBack),
                                        @(CGWebViewItemTypeForward),
                                        @(CGWebViewItemTypeFlexibleSpace),
                                        @(CGWebViewItemTypeReload),
                                        ];
    CGWebViewToolBar *toolBar   = [[CGWebViewToolBar alloc] initWithItemsType:itemsType];
    
    return [self initWithFrame:frame webView:webView toolBar:toolBar];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame webView:(CGWebView *)webView toolBar:(CGWebViewToolBar *)toolBar
{
    self = [super initWithFrame:frame];
    if (self) {
        _webView        = webView;
        _webViewToolBar = toolBar;
        
        [self addSubview:webView];
        [self addSubview:toolBar];
        
        NSArray *subviews   = @[_webView, _webViewToolBar];
        [subviews cg_autoArrangementType:CGSubviewsArrangementTypeVertical marginInsets:UIEdgeInsetsZero setupSubviewLayoutExculdingEdge:^BOOL(UIView * _Nonnull view, CGLayoutEdge exculdingEdge) {
            BOOL isExculdingEdge    = NO;
            if (view == self->_webViewToolBar && exculdingEdge == CGLayoutEdgeBottom) {
                isExculdingEdge     = YES;
            }
            return isExculdingEdge;
        }];
        [UIView cg_autoSetPriority:980 forConstraints:^{
            [self->_webViewToolBar cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom];
        }];
    }
    return self;
}

- (void)setWebViewToolBarHidden:(BOOL)isHidden animated:(BOOL)animated
{
    if (self.webViewToolBar.isHidden == isHidden) {
        return;
    }
    
    _isHiddenWebViewToolBar = isHidden;
    if (isHidden) {
        _bottomViewTopConstraint    = [self.webViewToolBar cg_autoInverseAttribute:CGLayoutEdgeTop toItem:self.webViewToolBar.superview];
    }else {
        [self.webViewToolBar.superview removeConstraint:_bottomViewTopConstraint];
    }
    
    [self setupUpdateConstraintsWithAnimated:animated completion:^(BOOL finished) {
        self.webViewToolBar.hidden  = isHidden;
    }];
}

- (void)setWebViewToolBarHeight:(CGFloat)webViewToolBarHeight animated:(BOOL)animated
{
    if (self.webViewToolBar.height == webViewToolBarHeight) {
        return;
    }
    
    if (self.webViewToolBar.isHidden) {
        animated    = NO;
    }
    
    _webViewToolBarHeight   = webViewToolBarHeight;
    if (_bottomViewHeightConstraint) {
        _bottomViewHeightConstraint.constant    = webViewToolBarHeight;
    }else {
        _bottomViewHeightConstraint = [self.webViewToolBar cg_autoDimension:CGDimensionHeight fixedLength:webViewToolBarHeight];
    }
    
    [self setupUpdateConstraintsWithAnimated:animated completion:nil];
}

- (void)setupUpdateConstraintsWithAnimated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion
{
    [self setNeedsUpdateConstraints];
    
    CGFloat duration    = animated ? 0.3 : 0;
    
    [UIView animateWithDuration:duration animations:^{
        
        [self layoutIfNeeded];
    } completion:completion];
}

#pragma mark - 设置属性
- (void)setWebViewToolBarHeight:(CGFloat)webViewToolBarHeight
{
    [self setWebViewToolBarHeight:webViewToolBarHeight animated:!self.disableAnimatedChangeViewStatus];
}

- (void)setIsHiddenWebViewToolBar:(BOOL)isHiddenWebViewToolBar
{
    [self setWebViewToolBarHidden:isHiddenWebViewToolBar animated:!self.disableAnimatedChangeViewStatus];
}

@end
