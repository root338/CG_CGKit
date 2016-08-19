//
//  CGWebView.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebView.h"
@import WebKit;

#import "UIView+CGAddConstraints.h"

#import "EXTKeyPathCoding.h"

@interface CGWebView ()

@property (nonatomic, strong, readwrite) WKWebView *webView;
@property (nonatomic, strong, readwrite) WKWebViewConfiguration *webViewConfiguration;
@property (nullable, nonatomic, strong, readwrite) WKNavigation *navigation;

@property (nullable, nonatomic, strong, readwrite) UIProgressView *progressView;
@end

@implementation CGWebView

- (void)initialization
{
    _isHiddeProgressView    = YES;
    _webViewConfiguration   = [[WKWebViewConfiguration alloc] init];
    _webView    = [[WKWebView alloc] initWithFrame:CGRectZero configuration:_webViewConfiguration];
    [self addSubview:_webView];
    [_webView cg_autoEdgesInsetsZeroToSuperview];
    
    NSString *titleKeyPath = [self webViewTitleKeyPath];
    [_webView addObserver:self forKeyPath:titleKeyPath options:NSKeyValueObservingOptionNew context:nil];
    NSString *progressKeyPath   = [self webViewProgressKeyPath];
    [_webView addObserver:self forKeyPath:progressKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setupProgressView
{
    if (self.isHiddeProgressView) {
        
        if (_progressView.superview) {
            
            [_progressView removeFromSuperview];
        }
    }else if (!self.progressView.superview) {
        
        [self addSubview:self.progressView];
        [self.progressView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:CGLayoutEdgeBottom];
    }
}

#pragma mark - 重写系统方法
- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self moveToWindowWithIsAddWindow:YES];
    }
}

/** 是否移动到窗口 */
- (void)moveToWindowWithIsAddWindow:(BOOL)isAddToWindow
{
    if (isAddToWindow) {
        [self setupProgressView];
    }
}

- (void)setupURLForString:(NSString *)paramString
{
    NSURL *url              = [NSURL URLWithString:paramString];
    NSURLRequest *request   = [NSURLRequest requestWithURL:url];
    self.navigation         = [self.webView loadRequest:request];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:[self webViewTitleKeyPath]]) {
        if (self.webViewTitleChangeCallback) {
            self.webViewTitleChangeCallback(change[NSKeyValueChangeNewKey]);
        }
    }else if ([keyPath isEqualToString:[self webViewProgressKeyPath]]) {
        
        CGFloat progress    = [change[NSKeyValueChangeNewKey] floatValue];
        if (self.webViewProgressChangeCallback) {
            self.webViewProgressChangeCallback(progress);
        }
        
        self.progressView.progress  = progress;
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 监听的KeyPath
- (NSString *)webViewTitleKeyPath
{
    return @keypath(_webView.title);
}

- (NSString *)webViewProgressKeyPath
{
    return @keypath(_webView.estimatedProgress);
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:[self webViewTitleKeyPath]];
    [self.webView removeObserver:self forKeyPath:[self webViewProgressKeyPath]];
}

#pragma mark - 设置属性
- (UIProgressView *)progressView
{
    if (_progressView) {
        return _progressView;
    }
    
    _progressView   = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    return _progressView;
}

- (void)setIsHiddeProgressView:(BOOL)isHiddeProgressView
{
    if (_isHiddeProgressView != isHiddeProgressView) {
        _isHiddeProgressView    = isHiddeProgressView;
        [self moveToWindowWithIsAddWindow:self.window != nil];
    }
}

@end
