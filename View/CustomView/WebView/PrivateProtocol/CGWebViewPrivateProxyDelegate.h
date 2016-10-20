//
//  CGWebViewPrivateProxyDelegate.h
//  QuickAskCommunity
//
//  Created by DY on 2016/10/20.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CGWebView;

@protocol CGWebViewPrivateProxyDelegate <NSObject>

@property (nullable, nonatomic, weak, readonly) CGWebView *webViewForPrivateObject;

@end
NS_ASSUME_NONNULL_END
