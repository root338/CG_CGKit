//
//  UIApplication+CGVerificationRemoteNotification.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGUNAuthorizationStatus) {
    CGUNAuthorizationStatusNotDetermined    = 0,
    CGUNAuthorizationStatusDenied,
    CGUNAuthorizationStatusAuthorized,
} __IOS_AVAILABLE(10.0);

@interface UIApplication (CGVerificationRemoteNotification)

/** 验证用户是否开启远程通知 */
+ (BOOL)cg_verifyUserOpenRemoteNotification NS_DEPRECATED_IOS(8_0, 10_0, "Use cg_notificationAuthorizationStatusWithCompletionHandle:");

+ (void)cg_notificationAuthorizationStatusWithCompletionHandle:(void (^) (CGUNAuthorizationStatus status))completion NS_AVAILABLE_IOS(10_0);

@end
NS_ASSUME_NONNULL_END
