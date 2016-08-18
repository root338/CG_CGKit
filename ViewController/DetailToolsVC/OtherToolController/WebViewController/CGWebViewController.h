//
//  CGWebViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebViewController;

@protocol CGWebViewControllerDelegate <NSObject>

@optional

/** web 底部视图 */
- (UIView *)bottomViewWithWebViewController:(CGWebViewController *)webViewController;
/** web 进度视图 */
- (UIView *)progressViewWithWebViewController:(CGWebViewController *)webViewController;

/** web 加载的进度 */
- (void)webViewController:(CGWebViewController *)webViewController webLoadProgress:(CGFloat)progress;
/** web 底部视图的高度 */
- (CGFloat)webBottomViewHeightWithWebViewController:(CGWebViewController *)webViewController;
/** 是否应该隐藏web底部视图 */
- (BOOL)shouldHiddenWebBottomViewWithWebViewController:(CGWebViewController *)webViewController;

@end

@class CGWebView;
NS_CLASS_AVAILABLE(10_10, 8_0) @interface CGWebViewController : CGBaseViewController

@property (nonatomic, strong, readonly) CGWebView   *webView;
@property (nonatomic, strong) UIView                *bottomView;
@property (nonatomic, strong) UIView                *progressView;

@property (nullable, nonatomic, weak) id<CGWebViewControllerDelegate> delegate;

/** 禁止自动设置标题 */
@property (nonatomic, assign) BOOL disableAutoSetupTitle;
/** 隐藏webView加载时的进度条 */
@property (nonatomic, assign) BOOL isHiddenWebViewLoadingProgress;
/** 隐藏底部视图工具条 */
@property (nonatomic, assign) BOOL isHiddenWebBottomView;
/** 设置底部视图的高度 */
@property (nonatomic, assign) CGFloat bottomViewHeight;
@end
NS_ASSUME_NONNULL_END