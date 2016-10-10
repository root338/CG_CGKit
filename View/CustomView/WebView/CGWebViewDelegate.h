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
@class CGWebView;

@protocol CGWebViewDelegate <NSObject>

@optional
- (BOOL)webView:(CGWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)webViewDidStartLoad:(CGWebView *)webView;
- (void)webViewDidFinishLoad:(CGWebView *)webView;
- (void)webView:(CGWebView *)webView didFailLoadWithError:(NSError *)error;


/** 获取webView的加载进度 */
- (void)webView:(CGWebView *)webView updateProgress:(CGFloat)progress;

/** 获取webView的title标签内容 
 *  @warning    在使用UIWebView时会多次回调该代理方法
 */
- (void)webView:(CGWebView *)webView webViewTitle:(NSString *)webViewTitle;

@end



NS_ASSUME_NONNULL_END
