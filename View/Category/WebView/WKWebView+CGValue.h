//
//  WKWebView+CGValue.h
//  TestCG_CGKit
//
//  Created by DY on 2016/12/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CGWKWebViewRunJavaScriptCallback) (_Nullable id resultValue, NSError * _Nullable error);

@interface WKWebView (CGValue)

//**
//*注意：
//*     1.该属性只能在web完全加载好之后进行设置(可以监听WKWebView的加载进度，尝试是否可以成功)
//*     2.当相关js加载好之后也可以调用
//**

/** //禁止长按弹出选择框 */
@property (assign, nonatomic) BOOL isDisableTouchCallout;

/** //禁止用户选择 */
@property (assign, nonatomic) BOOL isDisableUserSelect;

- (void)titleWithCompletionHandler:(nullable CGWKWebViewRunJavaScriptCallback)completionHandler;
- (void)HTMLWithCompletionHandler:(nullable CGWKWebViewRunJavaScriptCallback)completionHandler;

//////////////////////////////////////////////////////////////////

@end
NS_ASSUME_NONNULL_END
