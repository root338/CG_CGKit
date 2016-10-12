//
//  CGWebViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebView;
@interface CGWebViewController : CGBaseViewController

@property (nonatomic, strong, readonly) CGWebView   *webView;

/** 禁止自动设置标题 */
@property (nonatomic, assign) BOOL disableAutoSetupTitle;
/** 隐藏webView加载时的进度条 */
@property (nonatomic, assign) BOOL isHiddenProgressView;
/** 隐藏底部视图工具条 */
@property (nonatomic, assign) BOOL isHiddenWebViewToolBar;
@end

NS_ASSUME_NONNULL_END
