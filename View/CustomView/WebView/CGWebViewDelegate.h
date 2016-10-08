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
@class CGBaseWebView;

@protocol CGWebViewDelegate <NSObject>

@optional
- (BOOL)cg_webView:(CGBaseWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)cg_webViewDidStartLoad:(CGBaseWebView *)webView;
- (void)cg_webViewDidFinishLoad:(CGBaseWebView *)webView;
- (void)cg_webView:(CGBaseWebView *)webView didFailLoadWithError:(NSError *)error;


/** 获取webView的加载进度 */
- (void)cg_webView:(CGBaseWebView *)webView updateProgress:(CGFloat)progress;

/** 获取webView的title标签内容 
 *  @warning    在使用UIWebView时会多次回调该代理方法
 */
- (void)cg_webView:(CGBaseWebView *)webView webViewTitle:(NSString *)webViewTitle;

@end



NS_ASSUME_NONNULL_END
