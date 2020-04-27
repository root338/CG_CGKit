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

@class WKWebViewConfiguration, WKWebView, CGWebViewConfig;
@protocol WKNavigationDelegate, WKUIDelegate;

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

@property (nullable, nonatomic, readonly) UIWebView *webViewForUIWebView;
@property (nullable, nonatomic, readonly) WKWebView *webViewForWKWebView;

/** 加载的webView类型 */
@property (nonatomic, assign, readonly) CGWebViewType webViewType;

@property (nullable, nonatomic, weak) id<CGWebViewDelegate> delegate;

/** 当加载UIWebView时，自定义实现代理类时设置 */
@property (nullable, nonatomic, weak) id<UIWebViewDelegate> delegateForUIWebView;
/** 当加载WKWebView时，自定义实现代理类时设置 */
@property (nullable, nonatomic, weak) id<WKNavigationDelegate> delegateForWKWebView;
/** 当加载WKWebView时，自定义实现代理类时设置 */
@property (nullable, nonatomic, weak) id<WKUIDelegate> UIDelegateForWKWebView;

//WKWebView下，提示框／警告框／输入框，不会自动弹出，需要原生自行实现WKUIDelegate的协议方法来实现

@property (nullable, nonatomic, strong) CGWebViewConfig *webViewConfig;

/** 
 * 禁止用户长按弹出提示框
 * @param 默认 Debug 环境下为 NO， Release 环境下为 YES
 */
@property (nonatomic, assign) BOOL disableTouchCallout;

/**
 * 禁止用户选择
 * @param 默认 Debug 环境下为 NO， Release 环境下为 YES
*/
@property (nonatomic, assign) BOOL disableUserSelect;

//#pragma mark - 使用UIWebView类时的方法
//
//@property (nullable, nonatomic, weak) id<UIWebViewDelegate> proxyDelegateForUIWebView;

/** 
 *  在使用 WKWebView 时，js 弹出提示框，警告框，输入框时需要原生处理，此 UIViewController 指在设置 UIAlertController 时弹出使用
 *  在没有指定时，视图会自动搜索所在的 UIViewController
 */
@property (nullable, nonatomic, weak) UIViewController *viewController;

//webKit是否可用
+ (BOOL)isWebKitAvailable;

- (instancetype)initWithWebViewType:(CGWebViewType)webViewType;
- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType;

- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType configuration:(nullable WKWebViewConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

#pragma mark - 兼容API

@property (nullable, nonatomic, readonly) UIScrollView *scrollView API_AVAILABLE(ios(5.0));

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)baseURL;

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id obj, NSError * _Nullable error))completionHandler;

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

/** loadRequest: 方法加载的 NSURLRequest */
@property (nullable, nonatomic, strong) NSURLRequest *originLoadRequest;

@end


NS_ASSUME_NONNULL_END
