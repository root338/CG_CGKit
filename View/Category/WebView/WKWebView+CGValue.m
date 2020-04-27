//
//  WKWebView+CGValue.m
//  TestCG_CGKit
//
//  Created by DY on 2016/12/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WKWebView+CGValue.h"
#import <objc/runtime.h>

@implementation WKWebView (CGValue)

//禁止长按弹出选择框
- (void)setDisableTouchCallout:(BOOL)disable
{
    NSString *statusStr = disable ? @"none" : @"yes";
    NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitTouchCallout='%@';", statusStr];
    [self evaluateJavaScript:jsString completionHandler:nil];
}

- (BOOL)isDisableTouchCallout
{
    CGDebugAssert(NO, @"通过 js 获取不到 document.documentElement.style.webkitTouchCallout 状态");
    return YES;
}

//禁止用户选择
- (void)setDisableUserSelect:(BOOL)disable
{
    NSString *statusStr = disable ? @"none" : @"yes";
    NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitUserSelect='%@';", statusStr];
    [self evaluateJavaScript:jsString completionHandler:nil];
}

- (BOOL)isDisableUserSelect
{
    CGDebugAssert(NO, @"通过 js 获取不到 document.documentElement.style.webkitUserSelect 状态");
    return YES;
}

- (void)titleWithCompletionHandler:(CGWKWebViewRunJavaScriptCallback)completionHandler
{
    [self dealWithWebViewJS:@"document.title" completionHandler:completionHandler];
}

- (void)HTMLWithCompletionHandler:(CGWKWebViewRunJavaScriptCallback)completionHandler
{
    [self dealWithWebViewJS:@"document.innerHTML" completionHandler:completionHandler];
}

- (void)dealWithWebViewJS:(NSString *)jsStr completionHandler:(nullable CGWKWebViewRunJavaScriptCallback)completionHandler
{
    [self evaluateJavaScript:jsStr completionHandler:completionHandler];
}

@end
