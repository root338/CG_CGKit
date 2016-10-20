//
//  CGWKWebViewUIDelegateManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWKWebViewUIDelegateManager.h"

#import "CGWebView.h"

@interface CGWKWebViewUIDelegateManager ()

@property (nonatomic, readonly) CGWebView *webView;

@end

@implementation CGWKWebViewUIDelegateManager

+ (instancetype)createManagerWithDelegate:(id<CGWebViewDelegate>)delegate webViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate
{
    CGWKWebViewUIDelegateManager *UIDelegateManager = [[self alloc] init];
    UIDelegateManager.delegate                      = delegate;
    UIDelegateManager.webViewPrivateProxyDelegate   = webViewPrivateProxyDelegate;
    return UIDelegateManager;
}

- (CGWebView *)webView
{
    return self.webViewPrivateProxyDelegate.webViewForPrivateObject;
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


@end
