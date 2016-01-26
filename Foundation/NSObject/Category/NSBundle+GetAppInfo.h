//
//  NSBundle+GetAppInfo.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSBundle (GetAppInfo)

/** 获取 app info文件全部信息 */
+ (nullable NSDictionary *)getAppInfo;

/** 获取 app 版本号 */
+ (nullable NSString *)getAppInfoForShortVersion;

/** 获取 app 编译版本号 */
+ (nullable NSString *)getAppInfoForVersion;

/** 获取启动图片数组 */
+ (nullable NSArray *)getLaunchImages;
@end

NS_ASSUME_NONNULL_END