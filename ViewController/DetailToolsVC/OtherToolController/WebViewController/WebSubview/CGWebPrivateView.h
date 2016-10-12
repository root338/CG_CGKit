//
//  CGWebPrivateView.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebView, CGWebViewToolBar;

/** CGWebViewController 的 view */
@interface CGWebPrivateView : CGBaseView

@property (nonatomic, strong, readonly) CGWebView           * webView;
@property (nonatomic, strong, readonly) CGWebViewToolBar    * webViewToolBar;

/** 隐藏底部视图工具条 */
@property (nonatomic, assign) BOOL isHiddenWebViewToolBar;
/** 设置底部视图的高度 */
@property (nonatomic, assign) CGFloat webViewToolBarHeight;

/** 是否关闭动画改变视图的状态，默认YES */
@property (nonatomic, assign) BOOL disableAnimatedChangeViewStatus;

- (void)setWebViewToolBarHidden:(BOOL)isHidden animated:(BOOL)animated;
- (void)setWebViewToolBarHeight:(CGFloat)webViewToolBarHeight animated:(BOOL)animated;

- (instancetype)initWithFrame:(CGRect)frame webView:(CGWebView *)webView toolBar:(CGWebViewToolBar *)toolBar NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
