//
//  CGWKWebViewDelegateManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWKWebViewDelegateManager.h"

#import "EXTKeyPathCoding.h"
#import "CGWebViewDelegate.h"

#import "CGPrintLogHeader.h"

@interface CGWKWebViewDelegateManager ()
{
    BOOL monitorMark;
}
@end

@implementation CGWKWebViewDelegateManager

+ (instancetype)createManagerWithDelegate:(id<CGWebViewDelegate>)delegate webViewProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewProxyDelegate
{
    CGWKWebViewDelegateManager *manager = [self new];
    manager.delegate                    = delegate;
    manager.targetObject                = targetObj;
    return manager;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL result = YES;
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        NSURLRequest *request   = navigationAction.request;
        UIWebViewNavigationType type;
        switch (navigationAction.navigationType) {
            case WKNavigationTypeLinkActivated:
                type    = UIWebViewNavigationTypeLinkClicked;
                break;
            case WKNavigationTypeReload:
                type    = UIWebViewNavigationTypeReload;
                break;
            case WKNavigationTypeBackForward:
                type    = UIWebViewNavigationTypeBackForward;
                break;
            case WKNavigationTypeFormSubmitted:
                type    = UIWebViewNavigationTypeFormSubmitted;
                break;
            case WKNavigationTypeFormResubmitted:
                type    = UIWebViewNavigationTypeFormResubmitted;
                break;
            default:
                type    = UIWebViewNavigationTypeOther;
                break;
        }
        result  = [self.delegate webView:self.targetObject shouldStartLoadWithRequest:request navigationType:type];
    }
    
    WKNavigationActionPolicy policy;
    if (result) {
        
        policy  = WKNavigationActionPolicyAllow;
    }else {
        
        policy  = WKNavigationActionPolicyCancel;
        if ([self.delegate respondsToSelector:@selector(webViewDidCancelRequest:)]) {
            [self.delegate webViewDidCancelRequest:self.targetObject];
        }
    }
    
    if (decisionHandler) {
        decisionHandler(policy);
    }
}

- (BOOL)handleRequest

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self.targetObject];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:self.targetObject];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self.targetObject didFailLoadWithError:error];
    }
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
}

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler
{
    
}

// JS端调用prompt函数时，会触发此方法
// 要求输入一段文本
// 在原生输入得到文本内容后，通过completionHandler回调给JS
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    
}

#pragma mark - 设置监听
- (NSString *)webViewTitleKeyPath
{
    return @keypath(_webView.title);
}

- (NSString *)webViewProgressKeyPath
{
    return @keypath(_webView.estimatedProgress);
}

- (void)openWebViewMonitor
{
    if (monitorMark) {
        return;
    }
    monitorMark = YES;
    [self.webView addObserver:self forKeyPath:[self webViewTitleKeyPath] options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:[self webViewProgressKeyPath] options:NSKeyValueObservingOptionNew context:nil];
}

- (void)closeWebViewMonitor
{
    if (monitorMark == NO) {
        return;
    }
    monitorMark = NO;
    [self.webView removeObserver:self forKeyPath:[self webViewTitleKeyPath]];
    [self.webView removeObserver:self forKeyPath:[self webViewProgressKeyPath]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:[self webViewTitleKeyPath]]) {
        
        if ([self.delegate respondsToSelector:@selector(webView:webViewTitle:)]) {
            [self.delegate webView:self.targetObject webViewTitle:change[NSKeyValueChangeNewKey]];
        }
    }else if ([keyPath isEqualToString:[self webViewProgressKeyPath]]) {
        
        CGFloat progress    = [change[NSKeyValueChangeNewKey] floatValue];
        if ([self.delegate respondsToSelector:@selector(webView:updateProgress:)]) {
            [self.delegate webView:self.targetObject updateProgress:progress];
        }
    }
}

- (void)dealloc
{
    if (monitorMark) {
        [self closeWebViewMonitor];
    }
}

#pragma mark - 设置属性
- (void)setWebView:(WKWebView *)webView
{
    if (_webView != nil) {
        [self closeWebViewMonitor];
    }
    _webView    = webView;
    if (webView != nil) {
        [self openWebViewMonitor];
    }
}

@end
