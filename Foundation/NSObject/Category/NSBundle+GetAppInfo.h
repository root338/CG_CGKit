//
//  NSBundle+GetAppInfo.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (GetAppInfo)

/** 获取 app info文件全部信息 */
+ (NSDictionary *)getAppInfo;

/** 获取 app 版本号 */
+ (NSString *)getAppInfoForShortVersion;

/** 获取 app 编译版本号 */
+ (NSString *)getAppInfoForVersion;

/** 获取启动图片数组 */
+ (NSArray *)getLaunchImages;
@end
