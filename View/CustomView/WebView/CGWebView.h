//
//  CGWebView.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGWebViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class WKWebViewConfiguration, WKWebView;
@protocol WKNavigationDelegate;

/** webView加载的类型 */
typedef NS_ENUM(NSInteger, CGWebViewType) {
    /** 自动设置webView加载的类型 */
    CGWebViewTypeAuto,
    /** webView是UIWebView类型 */
    CGWebViewTypeUIWebView,
    /** webView是WKWebView类型 */
    CGWebViewTypeWKWebView,
};

@interface CGWebView<ObjectType> : UIView

//#if __IPHONE_OS_VERSION_MIN_REQUIRED

@property (nonatomic, strong, readonly) IBOutlet ObjectType webView;

/** 加载的webView类型 */
@property (nonatomic, assign, readonly) CGWebViewType webViewType;

@property (nullable, nonatomic, weak) id<CGWebViewDelegate> delegate;

/** 当加载UIWebView时，自定义实现代理类时设置 */
@property (nullable, nonatomic, weak) id<UIWebViewDelegate> delegateForUIWebView;
/** 当加载WKWebView时，自定义实现代理类时设置 */
@property (nullable, nonatomic, weak) id<WKNavigationDelegate> delegateForWKWebView;

//#pragma mark - 使用UIWebView类时的方法
//
//@property (nullable, nonatomic, weak) id<UIWebViewDelegate> proxyDelegateForUIWebView;

//webKit是否可用
+ (BOOL)isWebKitAvailable;

- (instancetype)initWithWebViewType:(CGWebViewType)webViewType;
- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType;

- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType configuration:(nullable WKWebViewConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

#pragma mark - 兼容API

@property (nullable, nonatomic, readonly) UIScrollView *scrollView NS_AVAILABLE_IOS(5_0);

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;

@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

- (void)reload;
- (void)stopLoading;

- (void)goBack;
- (void)goForward;

@property (nullable, nonatomic) NSString *title;

#pragma mark - 兼容扩展API
- (void)loadRequestWithURLString:(NSString *)urlString;

@end


NS_ASSUME_NONNULL_END
