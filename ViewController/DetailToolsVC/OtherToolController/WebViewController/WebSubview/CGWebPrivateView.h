//
//  CGWebPrivateView.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebView, CGWebBottomView;

/** CGWebViewController 的 view */
@interface CGWebPrivateView : CGBaseView

@property (nonatomic, strong, readonly) CGWebView       * webView;
@property (nonatomic, strong, readonly) CGWebBottomView * bottomView;

/** 隐藏底部视图工具条 */
@property (nonatomic, assign) BOOL isHiddenBottomView;
/** 设置底部视图的高度 */
@property (nonatomic, assign) CGFloat bottomViewHeight;

/** 是否关闭动画改变视图的状态，默认YES */
@property (nonatomic, assign) BOOL disableAnimatedChangeViewStatus;

- (void)setBottomViewHidden:(BOOL)isHidden animated:(BOOL)animated;
- (void)setBottomViewHeight:(CGFloat)bottomViewHeight animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END