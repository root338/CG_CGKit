//
//  NSBundle+GetAppInfo.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSBundle+GetAppInfo.h"

@implementation NSBundle (GetAppInfo)

+ (nullable NSDictionary *)getAppInfo
{
//    NSString *appInfoPath = [[NSBundle mainBundle] infoDictionary];
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];//[NSDictionary dictionaryWithContentsOfFile:appInfoPath];
    return appInfo;
}

+ (NSString *)getAppInfoForShortVersion
{
    NSDictionary *appInfo = [self getAppInfo];
    NSString *appVersion = [appInfo objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

+ (NSString *)getAppInfoForVersion
{
    NSDictionary *appInfo = [self getAppInfo];
    NSString *appVersion = [appInfo objectForKey:(__bridge NSString *)kCFBundleVersionKey];
    return appVersion;
}

+ (NSArray *)getLaunchImages
{
    NSDictionary *appInfo = [self getAppInfo];
    return [appInfo objectForKey:@"UILaunchImages"];
}
@end
