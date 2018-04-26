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

//WKWebView 相关代理方法设置
@interface CGWKWebViewDelegateManager : NSObject<WKNavigationDelegate>

//@property (nonatomic, weak) id<CGWebViewDelegate> delegate;

@property (nonatomic, weak) id<CGWebViewPrivateProxyDelegate> webViewPrivateProxyDelegate;

/** 开启webView的属性值监听 */
- (void)openWebViewMonitor;
/** 关闭webView的属性值监听 */
- (void)closeWebViewMonitor;

+ (instancetype)createManagerWithWebViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate;
@end

NS_ASSUME_NONNULL_END
