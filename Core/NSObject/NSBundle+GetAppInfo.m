//
//  NSBundle+GetAppInfo.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSBundle+GetAppInfo.h"

@implementation NSBundle (GetAppInfo)

+ (NSDictionary *)getAppInfo
{
    NSString *appInfoPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *appInfo = [NSDictionary dictionaryWithContentsOfFile:appInfoPath];
    return appInfo;
}

+ (NSString *)getAppInfoForShortVersion
{
    NSDictionary *appInfo = [self getAppInfo];
    NSString *appVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
    return appVersion ? appVersion : @"";
}

+ (NSString *)getAppInfoForVersion
{
    NSDictionary *appInfo = [self getAppInfo];
    NSString *appVersion = [appInfo objectForKey:(__bridge NSString *)kCFBundleVersionKey];
    return appVersion ? appVersion : @"";
}
@end
