//
//  CGWebView.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class WKWebView;
@class WKWebViewConfiguration;
@class WKNavigation;

NS_CLASS_AVAILABLE(10_10, 8_0) @interface CGWebView : CGBaseView

@property (nonatomic, strong, readonly) WKWebView *webView;
@property (nonatomic, strong, readonly) WKWebViewConfiguration *webViewConfiguration;
@property (nullable, nonatomic, strong, readonly) WKNavigation *navigation;

/** 加载的进度条视图 */
@property (nullable, nonatomic, strong, readonly) UIProgressView *progressView;
/** 是否隐藏加载进度条 */
@property (nonatomic, assign) BOOL isHiddeProgressView;

/** 获取到网页标题的回调 */
@property (nullable, nonatomic, copy) void (^webViewTitleChangeCallback) (NSString * _Nullable title);
/** 网页加载进度的改变回调 */
@property (nullable, nonatomic, copy) void (^webViewProgressChangeCallback) (CGFloat progress);

- (void)setupURLForString:(NSString *)paramString;

@end
NS_ASSUME_NONNULL_END