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

//#pragma mark - 使用UIWebView类时的方法
//
//@property (nullable, nonatomic, weak) id<UIWebViewDelegate> proxyDelegateForUIWebView;

//webKit是否可用
+ (BOOL)isWebKitAvailable;

- (instancetype)initWithWebViewType:(CGWebViewType)webViewType;
- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFrame:(CGRect)frame webViewType:(CGWebViewType)webViewType configuration:(nullable WKWebViewConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
@end


NS_ASSUME_NONNULL_END
