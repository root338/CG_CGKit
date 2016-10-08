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
    if ([self.delegate respondsToSelector:@selector(cg_webView:shouldStartLoadWithRequest:navigationType:)]) {
        result  = [self.delegate cg_webView:self.targetObject shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([self.delegate respondsToSelector:@selector(cg_webViewDidStartLoad:)]) {
        [self.delegate cg_webViewDidStartLoad:self.targetObject];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([self.delegate respondsToSelector:@selector(cg_webViewDidFinishLoad:)]) {
        [self.delegate cg_webViewDidFinishLoad:self.targetObject];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate cg_webView:self.targetObject didFailLoadWithError:error];
    }
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if ([self.delegate respondsToSelector:@selector(cg_webView:updateProgress:)]) {
        [self.delegate cg_webView:self.targetObject updateProgress:progress];
    }
    
    UIWebView *webView  = self.targetObject.webView;
    NSString *title = webView.title;
    if (title.length > 0) {
        if ([self.delegate respondsToSelector:@selector(cg_webView:webViewTitle:)]) {
            
            [self.delegate cg_webView:self.targetObject webViewTitle:title];
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
