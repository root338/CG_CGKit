//
//  CGWebPrivateView.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebView, CGWebPrivateView;


@protocol CGWebPrivateViewDelegate <NSObject>

/** 是否应该更新底部视图，只有当bottomView存在后在调用此方法 */
- (BOOL)shouldUpdateBottomViewWith:(CGWebPrivateView *)view;

/** web 底部视图 */
- (UIView *)bottomViewWithWebView:(CGWebPrivateView *)view;

/** web 进度视图 */
//- (UIView *)progressViewWithWebView:(CGWebPrivateView *)view;

/** web 底部视图的高度 */
- (CGFloat)bottomViewHeightWithWebView:(CGWebPrivateView *)view;

/** 是否应该隐藏web底部视图 */
- (BOOL)shouldHiddenBottomViewWithWebView:(CGWebPrivateView *)view;

@end


/** CGWebViewController 的 view */
@interface CGWebPrivateView : CGBaseView

@property (nonatomic, strong) CGWebView * webView;
@property (nonatomic, strong) UIView    * bottomView;
//@property (nonatomic, strong) UIView    * progressView;

/** 隐藏底部视图工具条 */
@property (nonatomic, assign) BOOL isHiddenBottomView;
/** 设置底部视图的高度 */
@property (nonatomic, assign) CGFloat bottomViewHeight;

@property (nullable, nonatomic, weak) id<CGWebPrivateViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<CGWebPrivateViewDelegate>)delegate;

- (void)reloadView;

@end

NS_ASSUME_NONNULL_END