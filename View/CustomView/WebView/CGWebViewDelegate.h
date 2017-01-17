//
//  CGWebViewDelegate.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CGWebView, WKFrameInfo;

typedef NS_ENUM(NSInteger, CGPrefixRequestType) {
    
    CGPrefixRequestTypeNone,
    CGPrefixRequestTypeTel,
    
};

@protocol CGWebViewDelegate <NSObject>

@optional
- (BOOL)webView:(CGWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

- (void)webViewDidStartLoad:(CGWebView *)webView;
- (void)webViewDidFinishLoad:(CGWebView *)webView;
- (void)webView:(CGWebView *)webView didFailLoadWithError:(NSError *)error;

/** webView:shouldStartLoadWithRequest:navigationType: 代理方法返回NO的时候调用 */
- (void)webViewDidCancelRequest:(CGWebView *)webView;

/** 获取webView的加载进度 */
- (void)webView:(CGWebView *)webView updateProgress:(CGFloat)progress;

/** 获取webView的title标签内容 
 *  @warning    在使用UIWebView时会多次回调该代理方法
 */
- (void)webView:(CGWebView *)webView webViewTitle:(NSString *)webViewTitle;

/**
 *  处理非 http:// 或 https:// 开头的链接
 *  @param completion 返回是否进行默认执行， YES执行默认程序
 */
- (BOOL)webView:(CGWebView *)webView handleOtherPrefixRequest:(NSURLRequest *)request type:(CGPrefixRequestType)type;

#pragma mark - WKWebView 下的代理方法
/**
 *  仅在 CGWebView 使用 WKWebView 时才可用
 */
/** JS端调用 alert 触发此方法 */
- (void)webView:(CGWebView *)webView runJavaScriptAlertPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(void))completionHandler NS_AVAILABLE_IOS(8_0);
/** JS端调用 confirm 触发此方法 */
- (void)webView:(CGWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler NS_AVAILABLE_IOS(8_0);
/** JS 端调用 prompt 触发此方法 */
- (void)webView:(CGWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler NS_AVAILABLE_IOS(8_0);

@end



NS_ASSUME_NONNULL_END
