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
            if ([[UIDevice currentDevice] _IOS_8_After]) {
                url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            }
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
    BOOL isOpen = NO;
    if (phoneStr) {
        
        phoneStr = [NSString stringWithFormat:@"tel:%@", phoneStr];
        NSURL *callPhoneURL = [NSURL URLWithString:phoneStr];
        
        isOpen  = [self callPhoneWithURL:callPhoneURL];
    }
    return isOpen;
}

+ (BOOL)callPhoneWithURL:(NSURL *)callPhoneURL
{
    return [self cg_openURL:callPhoneURL];
}

+ (BOOL)cg_openURLWithString:(NSString *)paramString
{
    return [self cg_openURL:[NSURL URLWithString:paramString]];
}

+ (BOOL)cg_openURL:(NSURL *)paramURL
{
    BOOL isOpen;
    UIApplication *application = [UIApplication sharedApplication];
    if ((isOpen = [application canOpenSystemAppURL:paramURL])) {
        isOpen = [application openSystemAppURL:paramURL];
    }
    return isOpen;
}

@end

@implementation UIDevice (GetSystemVersion)

@dynamic _IOS_7_After;
@dynamic _IOS_8_After;

- (BOOL)_IOS_7_After
{
    return [UIDevice currentSystemVersion] >= 7.0;
}

- (BOOL)_IOS_8_After
{
    return [UIDevice currentSystemVersion] >= 8.0;
}

+ (CGFloat)currentSystemVersion
{
    return [UIDevice currentDevice].systemVersion.floatValue;
}

@end
