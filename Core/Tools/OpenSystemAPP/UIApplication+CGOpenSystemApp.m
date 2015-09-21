//
//  UIApplication+OpenSystemApp.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/18.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIApplication+CGOpenSystemApp.h"

@implementation UIApplication (CGOpenSystemApp)

+ (BOOL)openSystemAppType:(CGOpenSystemAppType)appType
{
    return [[UIApplication sharedApplication] openSystemAppType:appType];
}

+ (BOOL)verifyOpenSystemAppType:(CGOpenSystemAppType)appType
{
    UIApplication *application = [UIApplication sharedApplication];
    return [application canOpenSystemAppURL:[application getOpenSystemAppURLWithType:appType]];
}

- (BOOL)openSystemAppType:(CGOpenSystemAppType)appType
{
    NSURL *openSystemAppURL = [self getOpenSystemAppURLWithType:appType];
    BOOL isOpen = [self canOpenSystemAppURL:openSystemAppURL];
    if (isOpen) {
        isOpen = [self openSystemAppURL:openSystemAppURL];
    }
    return isOpen;
}

- (NSURL *)getOpenSystemAppURLWithType:(CGOpenSystemAppType)appType
{
    NSURL *url = nil;
    
    switch (appType) {
        case CGOpenSystemAppType_SettingApp:
        {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
            
            url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
#else
            
            
#endif
        }
            break;
            
        default:
            break;
    }
    
    return url;
}

- (BOOL)canOpenSystemAppURL:(NSURL *)openSystemAppURL
{
    if (openSystemAppURL) {
        return [self canOpenURL:openSystemAppURL];
    }
    return NO;
}

- (BOOL)openSystemAppURL:(NSURL *)openSystemAppURL
{
    return [self openURL:openSystemAppURL];
}

#pragma mark -
+ (BOOL)callWithPhone:(NSString *)phoneStr
{
    BOOL isOpen;
    if (phoneStr) {
        
        phoneStr = [NSString stringWithFormat:@"tel:%@", phoneStr];
        NSURL *callPhoneURL = [NSURL URLWithString:phoneStr];
        
        UIApplication *application = [UIApplication sharedApplication];
        if ((isOpen = [application canOpenSystemAppURL:callPhoneURL])) {
            isOpen = [application openSystemAppURL:callPhoneURL];
        }
        
    }
    return isOpen;
}
@end
