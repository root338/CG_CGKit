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

@interface CGWebViewController ()
{
    UIBarButtonItem *goBackItem;
    UIBarButtonItem *goForwardItem;
}
@property (nonatomic, strong, readwrite) CGWebView *webView;
@property (nonatomic, strong, readwrite) UIProgressView *progressView;

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
/** 设置进度条 */
- (void)setupProgressView
{
    if (!self.isHiddenWebViewLoadingProgress) {
        if (!self.progressView.superview) {
            [self.view addSubview:self.progressView];
            [self.progressView cg_autoEdgesToViewController:self withInsets:UIEdgeInsetsZero exculdingEdge:CGLayoutEdgeBottom];
        }
    }
}

/** 设置webView */
- (void)setupWebView
{
    if (!self.webView.superview) {
        [self.view addSubview:self.webView];
        [self.webView cg_autoEdgesInsetsZeroToViewController:self exculdingEdge:CGLayoutEdgeBottom];
        
//      //约束添加到视图之后不能设置优先级，当UIView+CGAddConstraints扩展完善再使用吧
        //[self.webView cg_bottomLayoutGuideOfViewController:self];
        NSLayoutConstraint *bottomLayoutConstraint = [NSLayoutConstraint constraintWithItem:self.webView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        bottomLayoutConstraint.priority = 900;
        [self.webView.superview addConstraint:bottomLayoutConstraint];
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
    if (!self.isHiddenToolBar) {
        
        if (!self.toolbar.superview) {
            
            [self.view addSubview:self.toolbar];
            [self.toolbar cg_autoEdgesInsetsZeroToViewController:self exculdingEdge:CGLayoutEdgeTop];
            [self.toolbar cg_attribute:NSLayoutAttributeTop toItem:self.webView attribute:NSLayoutAttributeBottom];
            [self.toolbar cg_autoDimension:CGDimensionHeight fixedLength:44];
        }
    }
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
@end
