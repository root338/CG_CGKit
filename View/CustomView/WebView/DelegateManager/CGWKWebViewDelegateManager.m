//
//  CGWKWebViewDelegateManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWKWebViewDelegateManager.h"

#import "CGWebView.h"

#import "WKWebView+CGValue.h"
#import "UIView+CGSearchView.h"

#import "UIViewController+CGAlert.h"

#import "EXTKeyPathCoding.h"
#import "CGWebViewDelegate.h"
#import "NSString+VerificationString.h"

#import "UIApplication+CGOpenSystemApp.h"

#import "CGPrintLogHeader.h"

@interface CGWKWebViewDelegateManager ()
{
    BOOL monitorMark;
}

@property (nonatomic, readonly) CGWebView *webView;
@property (nonatomic, readonly) id<CGWebViewDelegate> delegate;
@property (nonatomic, strong) WKWebView *targetMonitorView;

@end

@implementation CGWKWebViewDelegateManager

+ (instancetype)createManagerWithWebViewPrivateProxyDelegate:(nonnull id)webViewPrivateProxyDelegate
{
    CGWKWebViewDelegateManager *manager = [self new];
    manager.webViewPrivateProxyDelegate = webViewPrivateProxyDelegate;
    return manager;
}

- (CGWebView *)webView
{
    return self.webViewPrivateProxyDelegate.webViewForPrivateObject;
}

- (id<CGWebViewDelegate>)delegate
{
    return self.webView.delegate;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL result = YES;
    NSURLRequest *request   = navigationAction.request;
    
    result  = [self webView:webView handleNotHTTPPrefixRequest:request];
    
    if (result && [self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        
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
        result  = [self.delegate webView:self.webView shouldStartLoadWithRequest:request navigationType:type];
    }
    
    WKNavigationActionPolicy policy;
    if (result) {
        
        policy  = WKNavigationActionPolicyAllow;
    }else {
        
        policy  = WKNavigationActionPolicyCancel;
        if ([self.delegate respondsToSelector:@selector(webViewDidCancelRequest:)]) {
            [self.delegate webViewDidCancelRequest:self.webView];
        }
    }
    
    if (decisionHandler) {
        decisionHandler(policy);
    }
}

- (BOOL)webView:(WKWebView *)webView handleNotHTTPPrefixRequest:(NSURLRequest *)request
{
    BOOL isResult   = YES;
    NSURL *targetURL = request.URL;
    
    CGPrefixRequestType type = CGPrefixRequestTypeNone;
    if ([targetURL.scheme hasPrefix:@"tel"]) {
        
        type        = CGPrefixRequestTypeTel;
        isResult    = NO;
    }else if ([targetURL.scheme isEqualToString:@"itms-appss"] && [targetURL.host isEqualToString:@"itunes.apple.com"]) {
        
        type        = CGPrefixRequestTypeItunes;
        isResult    = NO;
    }
    
    BOOL dealDefaltOption   = YES;
    if (type != CGPrefixRequestTypeNone && [self.delegate respondsToSelector:@selector(webView:handleOtherPrefixRequest:type:)]) {
        
        dealDefaltOption    = [self.delegate webView:self.webView handleOtherPrefixRequest:request type:type];
    }
    
    if (dealDefaltOption) {
        
        
        switch (type) {
            case CGPrefixRequestTypeTel:
            {
                NSString *phoneStr  = targetURL.resourceSpecifier;
                [[self viewController] showAlertViewWithTitle:nil message:phoneStr cancelTitle:@"取消" otherTitle:@"呼叫" resultCallback:^(BOOL isCancel) {
                    if (!isCancel) {
                        [UIApplication callPhoneWithURL:request.URL];
                    }
                }];
            }
                break;
            case CGPrefixRequestTypeItunes:
            {
                [[self viewController] showAlertViewWithTitle:nil message:@"在“App Store”中打开链接吗?" cancelTitle:@"取消" otherTitle:@"打开" resultCallback:^(BOOL isCancel) {
                    if (!isCancel) {
                        [UIApplication cg_openURL:request.URL];
                    }
                }];
            }
                break;
            default:
                break;
        }
    }
    
    return isResult;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self.webView];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    webView.disableTouchCallout = self.webView.disableTouchCallout;
    webView.disableUserSelect = self.webView.disableUserSelect;
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:self.webView];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self.webView didFailLoadWithError:error];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self.webView didFailLoadWithError:error];
    }
}

#pragma mark - 设置监听
- (NSString *)webViewTitleKeyPath
{
    return @keypath(self.webView.webViewForWKWebView, title);
}

- (NSString *)webViewProgressKeyPath
{
    
    return @keypath(self.webView.webViewForWKWebView, estimatedProgress);
}

- (void)openWebViewMonitor
{
    WKWebView *webView      = self.webView.webViewForWKWebView;
    if (webView != self.targetMonitorView) {
        self.targetMonitorView  = webView;
    }
    
    if (monitorMark) {
        return;
    }
    
    if (webView) {
        
        monitorMark = YES;
        [webView addObserver:self forKeyPath:[self webViewTitleKeyPath] options:NSKeyValueObservingOptionNew context:nil];
        [webView addObserver:self forKeyPath:[self webViewProgressKeyPath] options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)closeWebViewMonitor
{
    self.targetMonitorView = nil;
}

- (void)closeMonitorWithWebView:(WKWebView *)webView
{
    if (monitorMark == NO) {
        return;
    }
    monitorMark = NO;
    [webView removeObserver:self forKeyPath:[self webViewTitleKeyPath]];
    [webView removeObserver:self forKeyPath:[self webViewProgressKeyPath]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:[self webViewTitleKeyPath]]) {
        
        if ([self.delegate respondsToSelector:@selector(webView:webViewTitle:)]) {
            [self.delegate webView:self.webView webViewTitle:change[NSKeyValueChangeNewKey]];
        }
    }else if ([keyPath isEqualToString:[self webViewProgressKeyPath]]) {
        
        CGFloat progress    = [change[NSKeyValueChangeNewKey] floatValue];
        if ([self.delegate respondsToSelector:@selector(webView:updateProgress:)]) {
            [self.delegate webView:self.webView updateProgress:progress];
        }
    }
}

- (UIViewController *)viewController
{
    UIViewController *viewController    = self.webView.viewController;
    if (viewController == nil) {
        viewController  = self.webView.viewControllerForLate;
    }
    return viewController;
}

- (void)setTargetMonitorView:(WKWebView *)targetMonitorView
{
    if (_targetMonitorView) {
        [self closeMonitorWithWebView:_targetMonitorView];
    }
    _targetMonitorView = targetMonitorView;
}

@end
