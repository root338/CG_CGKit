//
//  UIWebView+CGValue.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/12.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIWebView+CGValue.h"
#import <objc/runtime.h>

@implementation UIWebView (CGValue)

//禁止长按弹出选择框
- (void)setDisableTouchCallout:(BOOL)disable
{
    NSString *statusStr = disable ? @"none" : @"yes";
    NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitTouchCallout='%@';", statusStr];
    
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (BOOL)isDisableTouchCallout
{
    CGDebugAssert(NO, @"获取不到 webkitTouchCallout 状态");
    return YES;
}

//禁止用户选择
- (void)setDisableUserSelect:(BOOL)disable
{
    NSString *statusStr = disable ? @"none" : @"yes";
    NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitUserSelect='%@';", statusStr];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

- (BOOL)isDisableUserSelect
{
    CGDebugAssert(NO, @"获取不到 webkitUserSelect 状态");
    return YES;
}

- (NSString *)title
{
    NSString *title = [self dealWithWebViewJS:@"document.title"];
    return title;
}

- (NSString *)HTML
{
    NSString *HTML  = [self dealWithWebViewJS:@"document.innerHTML"];
    return HTML;
}

- (nullable NSString *)dealWithWebViewJS:(NSString *)jsStr
{
    return [self stringByEvaluatingJavaScriptFromString:jsStr];
}
@end
