//
//  CGUIWebViewDelegateManager.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGUIWebViewDelegateManager.h"
#import "NJKWebViewProgress.h"

#import "CGWebViewDelegate.h"

#import "CGWebView.h"

#import "UIWebView+CGValue.h"

@interface CGUIWebViewDelegateManager ()<NJKWebViewProgressDelegate>
{
    NJKWebViewProgress  *progressProxy;
}

@end

@implementation CGUIWebViewDelegateManager

+ (instancetype)createManagerWithDelegate:(id<CGWebViewDelegate>)delegate targetObj:(nonnull CGWebView *)targetObj
{
    CGUIWebViewDelegateManager *manager = [[self alloc] init];
    manager.delegate                    = delegate;
    manager.targetObject                = targetObj;
    return manager;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL result = YES;
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        result  = [self.delegate webView:self.targetObject shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    if (result == NO && [self.delegate respondsToSelector:@selector(webViewDidCancelRequest:)]) {
        [self.delegate webViewDidCancelRequest:self.targetObject];
    }
    return result;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:self.targetObject];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:self.targetObject];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:self.targetObject didFailLoadWithError:error];
    }
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if ([self.delegate respondsToSelector:@selector(webView:updateProgress:)]) {
        [self.delegate webView:self.targetObject updateProgress:progress];
    }
    
    UIWebView *webView  = self.targetObject.webView;
    NSString *title = webView.title;
    if (title.length > 0) {
        if ([self.delegate respondsToSelector:@selector(webView:webViewTitle:)]) {
            
            [self.delegate webView:self.targetObject webViewTitle:title];
        }
    }
}

- (void)resetWebViewLoad
{
    [progressProxy reset];
}

#pragma mark - 设置属性

- (id<UIWebViewDelegate>)webViewProxyDelegate
{
    if (progressProxy == nil) {
        progressProxy   = [[NJKWebViewProgress alloc] init];
        progressProxy.webViewProxyDelegate  = self;
        progressProxy.progressDelegate      = self;
    }
    return progressProxy;
}

@end
