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

#import "UIView+CGAddConstraints.h"

#import "Value+Constant.h"

@interface CGWebViewController ()
{
    UIBarButtonItem *goBackItem;
    UIBarButtonItem *goForwardItem;
}
@property (nonatomic, strong, readwrite) CGWebView *webView;

@property (nonatomic, strong) UIProgressView *progressDefultView;
@property (nonatomic, strong) UIToolbar *toolbar;
@end

@implementation CGWebViewController

#pragma mark - 事件
- (void)handleWebViewBack:(UIBarButtonItem *)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupWebView];
    [self setupProgressView];
    [self setupToolBar];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark - 设置页面内容
- (void)setupContentView
{
    if (!self.webView.superview) {
        
    }
}

/** 设置进度条 */
- (void)setupProgressView
{
    if (!self.isHiddenWebViewLoadingProgress) {
        if (!self.progressView.superview) {
            [self.navigationController.navigationBar addSubview:self.progressView];
            [self.progressView cg_autoEdgesInsetsZeroToSuperviewExcludingEdge:CGLayoutEdgeTop];
        }
    }
}

/** 设置webView */
- (void)setupWebView
{
    if (!self.webView.superview) {
        [self.view addSubview:self.webView];
        [self.webView cg_autoEdgesInsetsZeroToViewController:self exculdingEdge:CGLayoutEdgeBottom];
        
        [UIView cg_autoSetPriority:999 forConstraints:^{
            [self.webView cg_bottomLayoutGuideOfViewController:self];
        }];
    }
    
    __weak typeof(self) weakSelf    = self;
    if (!self.disableAutoSetupTitle) {
        self.webView.webViewTitleChangeCallback = ^(NSString *title) {
            weakSelf.title  = title;
        };
    }
    
    if (!self.isHiddenWebViewLoadingProgress) {
        self.webView.webViewProgressChangeCallback = ^(CGFloat progress) {
            weakSelf.progressView.progress  = progress;
        };
    }
}

/** 设置工具栏 */
- (void)setupToolBar
{
    if (!self.isHiddenWebBottomView) {
        
        if (!self.toolbar.superview) {
            
            [self.view addSubview:self.toolbar];
            [self.toolbar cg_autoEdgesInsetsZeroToViewController:self exculdingEdge:CGLayoutEdgeTop];
            [self.toolbar cg_attribute:NSLayoutAttributeTop toItem:self.webView attribute:NSLayoutAttributeBottom];
            [self.toolbar cg_autoDimension:CGDimensionHeight fixedLength:44];
        }
    }
}

- (void)updateViewConstraints
{
    
    [super updateViewConstraints];
}

#pragma mark - 设置属性

- (CGWebView *)webView
{
    if (_webView) {
        return _webView;
    }
    
    _webView = [[CGWebView alloc] initWithFrame:CGRectZero];
    
    return _webView;
}

- (UIProgressView *)progressView
{
    if (_progressView) {
        return _progressView;
    }
    
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    
    return _progressView;
}

- (UIToolbar *)toolbar
{
    if (_toolbar) {
        return _toolbar;
    }
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    
    UIBarButtonItem *redo   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:nil action:nil];
    UIBarButtonItem *undo   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:nil action:nil];
    UIBarButtonItem *flexibleSpace  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *refresh        = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:nil action:nil];
    
    NSArray *items  = @[redo, undo, flexibleSpace, refresh];
    [_toolbar setItems:items];
    
    return _toolbar;
}

- (UIView *)bottomView
{
    if (_bottomView) {
        return _bottomView;
    }
    
    _bottomView = self.toolbar;
    
    return _bottomView;
}
@end
