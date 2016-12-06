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
- (void)setIsDisableTouchCallout:(BOOL)disable
{
    if (self.isDisableTouchCallout != disable) {
    
        NSString *statusStr = disable ? @"none" : @"yes";
        NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitTouchCallout='%@';", statusStr];
        
        [self dealWithWebViewJS:jsString completionHandler:nil];
        objc_setAssociatedObject(self, @selector(isDisableTouchCallout), @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (BOOL)isDisableTouchCallout
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

//禁止用户选择
- (void)setIsDisableUserSelect:(BOOL)disable
{
    if (self.isDisableUserSelect != disable) {
    
        NSString *statusStr = disable ? @"none" : @"yes";
        NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitUserSelect='%@';", statusStr];
        
        [self dealWithWebViewJS:jsString completionHandler:nil];
        
        objc_setAssociatedObject(self, @selector(isDisableUserSelect), @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (BOOL)isDisableUserSelect
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
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
