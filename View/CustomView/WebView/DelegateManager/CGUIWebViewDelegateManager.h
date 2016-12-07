//
//  CGUIWebViewDelegateManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGWebViewPrivateProxyDelegate.h"

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@class CGWebView;

@interface CGUIWebViewDelegateManager : NSObject<UIWebViewDelegate>

@property (nonatomic, weak) id<CGWebViewPrivateProxyDelegate> webViewPrivateProxyDelegate;
@property (nonatomic, readonly) id<UIWebViewDelegate> webViewProxyDelegate;

+ (instancetype)createManagerWithWebViewPrivateProxyDelegate:(id<CGWebViewPrivateProxyDelegate>)webViewPrivateProxyDelegate;

- (void)resetWebViewLoad;
@end

NS_ASSUME_NONNULL_END
