//
//  CGWebPrivateView.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGWebView;

/** CGWebViewController 的 view */
@interface CGWebPrivateView : CGBaseView

@property (nonatomic, strong) CGWebView * webView;
@property (nonatomic, strong) UIView    * bottomView;
@property (nonatomic, strong) UIView    * progressView;

@end

NS_ASSUME_NONNULL_END