//
//  CGWebViewConfig.h
//  TestCG_CGKit
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/** WKWebView 相关功能设置 */
@interface CGWKWebViewConfig : CGBaseObject

/** 关闭标题的监听，默认NO */
@property (nonatomic, assign) BOOL disableTitleMonitor;
/** 关闭加载进度的监听，默认NO */
@property (nonatomic, assign) BOOL disableProgressMonitor;

@end

/** UIWebView 相关功能设置 */
@interface CGUIWebViewConfig : CGBaseObject

@end

/** CGWebView 相关配置 */
@interface CGWebViewConfig : CGBaseObject

/** 关闭自动处理打电话链接 tel: 开头的NSURL请求，默认NO */
@property (nonatomic, assign) BOOL disableHandleCallPhoneLink;

@property (nullable, nonatomic, strong) CGWKWebViewConfig *WKWebViewConfig;

@property (nullable, nonatomic, strong) CGUIWebViewConfig *UIWebViewConfig;

@end

NS_ASSUME_NONNULL_END
