//
//  UIApplication+OpenSystemApp.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/18.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  打开系统App的类型
 */
typedef NS_ENUM(NSInteger, CGOpenSystemAppType){
    /**
     *  设置
     */
    CGOpenSystemAppType_SettingApp,
};

@interface UIApplication (CGOpenSystemApp)

/**
 *  打开系统app
 *
 *  @param appType 系统app的类型
 *
 *  @return 是否成功
 */
+ (BOOL)openSystemAppType:(CGOpenSystemAppType)appType;

/**
 *  验证是否可以打开
 *
 *  @param appType 系统app的类型
 *
 *  @return 是否可以打开
 */
+ (BOOL)verifyOpenSystemAppType:(CGOpenSystemAppType)appType;

/**
 *  打开系统app
 *
 *  @param appType 系统app的类型
 *
 *  @return 是否成功
 */
- (BOOL)openSystemAppType:(CGOpenSystemAppType)appType;

#pragma mark - 具体功能
/**
 *  调用系统的打电话功能
 *
 *  @param phoneStr 电话号码
 *
 *  @return 是否成功
 */
+ (BOOL)callWithPhone:(NSString *)phoneStr;


+ (BOOL)callPhoneWithURL:(NSURL *)callPhoneURL;


+ (BOOL)cg_openURLWithString:(NSString *)paramString;

+ (BOOL)cg_openURL:(NSURL *)paramURL;
@end

@interface UIDevice (GetSystemVersion)

/** 当前系统为 iOS 7 以后版本 */
@property (assign, nonatomic, readonly) BOOL _IOS_7_After;

/** 当前系统为 iOS 8 以后版本  */
@property (assign, nonatomic, readonly) BOOL _IOS_8_After;

/** 当前系统版本 */
+ (CGFloat)currentSystemVersion;

@end
NS_ASSUME_NONNULL_END
