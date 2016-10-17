//
//  CGWebViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

@import WebKit;

#import "CGWebViewController.h"

#import "CGWebView.h"
#import "CGWebPrivateView.h"
#import "CGWebViewToolBar.h"
#import "CGWebViewProgressView.h"

#import "UIView+CGAddConstraints.h"

#import "Value+Constant.h"

@interface CGWebViewController ()<CGWebViewDelegate, CGWebViewToolBarDelegate>
{
    
    CGWebViewProgressView *_progressView;
}

@property (nonatomic, strong) UIProgressView    *progressDefultView;

@property (nonatomic, strong) CGWebPrivateView  *privateView;

@property (nonatomic, assign) CGWebViewItemType currentToolBarItemType;
@end

@implementation CGWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.privateView.superview) {
        [self.view addSubview:self.privateView];
        [self.privateView cg_autoEdgesInsetsZeroToSuperview];
    }
    [self updateToolBarStatus];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addProgressView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeProgressView];
}

#pragma mark - CGWebViewToolBarDelegate

- (void)webViewToolBar:(CGWebViewToolBar *)webViewToolBar itemType:(CGWebViewItemType)itemType
{
    self.currentToolBarItemType = itemType;
}

#pragma mark - CGWebViewDelegate
- (BOOL)webView:(CGWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webView:(CGWebView *)webView webViewTitle:(NSString *)webViewTitle
{
    if (!self.disableAutoSetupTitle) {
        self.title  = webViewTitle;
    }
}

- (void)webView:(CGWebView *)webView updateProgress:(CGFloat)progress
{
    if (!self.isHiddenProgressView) {
        [self getProgressView].progress = progress;
    }
    [self updateToolBarStatus];
}

- (void)webViewDidStartLoad:(CGWebView *)webView
{
    if (_currentToolBarItemType == CGWebViewItemTypeNone) {
        self.currentToolBarItemType = CGWebViewItemTypeForward;
    }
    [self addProgressView];
}

- (void)webViewDidFinishLoad:(CGWebView *)webView
{
    [self hiddenProgressView];
    self.currentToolBarItemType = CGWebViewItemTypeNone;
}

- (void)webView:(CGWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hiddenProgressView];
    self.currentToolBarItemType = CGWebViewItemTypeNone;
}

#pragma mark - 设置进度条
- (CGWebViewProgressView *)getProgressView
{
    if (_progressView != nil) {
        return _progressView;
    }
    
    if (self.isHiddenProgressView) {
        return nil;
    }
    _progressView   = [[CGWebViewProgressView alloc] init];
    
    return _progressView;
}

- (void)addProgressView
{
    if (self.isHiddenProgressView || self.webView.isLoading == NO) {
        return;
    }
    
    if ([[self getProgressView] superview] == nil) {
        
        [self.navigationController.navigationBar addSubview:_progressView];
        [_progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.height - _progressView.height, self.navigationController.navigationBar.width, _progressView.height)];
        _progressView.autoresizingMask  = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    }
    
    if (_progressView.isHidden != NO) {
        [_progressView setHidden:NO];
    }
}

- (void)hiddenProgressView
{
    _progressView.hidden = YES;
}

- (void)removeProgressView
{
    if ([_progressView superview] != nil) {
        [_progressView removeFromSuperview];
    }
}

#pragma mark - 设置属性

- (CGWebPrivateView *)privateView
{
    if (_privateView) {
        return _privateView;
    }
    
    _privateView = [[CGWebPrivateView alloc] init];
    _privateView.webView.delegate   = self;
    _privateView.webViewToolBar.toolBarProxyDelegate    = self;
    
    return _privateView;
}

- (CGWebView *)webView
{
    return self.privateView.webView;
}

- (void)setIsHiddenWebViewToolBar:(BOOL)isHiddenWebViewToolBar
{
    _isHiddenWebViewToolBar = isHiddenWebViewToolBar;
    [self.privateView setIsHiddenWebViewToolBar:isHiddenWebViewToolBar];
}

- (void)setCurrentToolBarItemType:(CGWebViewItemType)currentToolBarItemType
{
    
    _currentToolBarItemType = currentToolBarItemType;
    switch (currentToolBarItemType) {
        case CGWebViewItemTypeForward:
        {
            [self.webView goForward];
        }
            break;
        case CGWebViewItemTypeReload:
        {
            [self.webView reload];
        }
            break;
        case CGWebViewItemTypeBack:
        {
            [self.webView goBack];
        }
            break;
        case CGWebViewItemTypeStopLoading:
        {
            [self.webView stopLoading];
        }
            break;
        default:
            break;
    }
}

- (void)updateToolBarStatus
{
    self.privateView.webViewToolBar.backItem.enabled    = self.webView.canGoBack;
    self.privateView.webViewToolBar.forwardItem.enabled = self.webView.canGoForward;
}

@end
