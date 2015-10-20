//
//  CGBaseWebView.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseWebView.h"

@implementation CGBaseWebView

- (void)setIsDisableTouchCallout:(BOOL)isDisableTouchCallout
{
    if (isDisableTouchCallout) {
        //禁止长按弹出选择框
        [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    }
    _isDisableTouchCallout = isDisableTouchCallout;
}

- (void)setIsDisableUserSelect:(BOOL)isDisableUserSelect
{
    if (isDisableUserSelect) {
        //禁止用户选择
        [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    }
    _isDisableUserSelect = isDisableUserSelect;
}
@end
