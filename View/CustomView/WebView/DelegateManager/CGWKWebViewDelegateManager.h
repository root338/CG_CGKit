//
//  CGWKWebViewDelegateManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGWebViewPrivateProxyDelegate.h"

@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@class CGWebView;
@protocol CGWebViewDelegate;

//WKWebView 相关代理方法设置
@interface CGWKWebViewDelegateManager : NSObject<WKNavigationDelegate>

@property (nonatomic, weak) id<CGWebViewDelegate> delegate;

/** !!!注意使用，使用assign的原因：在使用weak时，在dealloc中使用此属性时会它会为nil，而在这时WKWebView添加的监听还没有被销毁，所以使用assign属性，这时不会为nil */
@property (nonatomic, assign) id<CGWebViewPrivateProxyDelegate> webViewPrivateProxyDelegate;



/** 开启webView的属性值监听 */
- (void)openWebViewMonitor;
/** 关闭webView的属性值监听 */
- (void)closeWebViewMonitor;

+ (instancetype)createManagerWithDelegate:(id<CGWebViewDelegate>)delegate webViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate;
@end

NS_ASSUME_NONNULL_END
