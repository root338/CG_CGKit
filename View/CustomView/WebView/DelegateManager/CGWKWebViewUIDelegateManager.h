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

@interface CGWKWebViewUIDelegateManager : CGBaseObject<WKUIDelegate>

@property (nonatomic, weak) id<CGWebViewPrivateProxyDelegate> webViewPrivateProxyDelegate;

+ (instancetype)createManagerWithWebViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate;

@end

NS_ASSUME_NONNULL_END
