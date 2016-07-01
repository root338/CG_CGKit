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
- (void)setIsDisableTouchCallout:(BOOL)disable
{
//    if (self.isDisableTouchCallout != disable) {
    
        NSString *statusStr = disable ? @"none" : @"yes";
        NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitTouchCallout='%@';", statusStr];
        
        [self dealWithWebViewJS:jsString];
        objc_setAssociatedObject(self, @selector(isDisableTouchCallout), @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
}

- (BOOL)isDisableTouchCallout
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

//禁止用户选择
- (void)setIsDisableUserSelect:(BOOL)disable
{
//    if (self.isDisableUserSelect != disable) {
    
        NSString *statusStr = disable ? @"none" : @"yes";
        NSString *jsString  = [NSString stringWithFormat:@"document.documentElement.style.webkitUserSelect='%@';", statusStr];
    
        [self dealWithWebViewJS:jsString];
    
        objc_setAssociatedObject(self, @selector(isDisableUserSelect), @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
}

- (BOOL)isDisableUserSelect
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
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
