//
//  CGWKWebViewUIDelegateManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGWebViewPrivateProxyDelegate.h"

@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@class CGWebView;
@protocol CGWebViewDelegate;

@interface CGWKWebViewUIDelegateManager : CGBaseObject<WKUIDelegate>

@property (nonatomic, weak) id<CGWebViewDelegate> delegate;
@property (nonatomic, weak) id<CGWebViewPrivateProxyDelegate> webViewPrivateProxyDelegate;

+ (instancetype)createManagerWithDelegate:(id<CGWebViewDelegate>)delegate webViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate;

@end

NS_ASSUME_NONNULL_END
