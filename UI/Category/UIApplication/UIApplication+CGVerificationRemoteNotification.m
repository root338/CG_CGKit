//
//  UIApplication+CGVerificationRemoteNotification.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIApplication+CGVerificationRemoteNotification.h"
#import "CGVerifyIOSVersionHeader.h"

@import UserNotifications;

@implementation UIApplication (CGVerificationRemoteNotification)

+ (BOOL)cg_verifyUserOpenRemoteNotification
{
    BOOL isResult = false;
    
    UIApplication *application = [UIApplication sharedApplication];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
    if (_CG_IOS_8_0_AFTER) {
#endif
        
        UIUserNotificationSettings *settings = [application currentUserNotificationSettings];
        isResult = (settings.types != UIUserNotificationTypeNone);
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
    }else {

        UIRemoteNotificationType type = [application enabledRemoteNotificationTypes];
        isResult = (type != UIRemoteNotificationTypeNone);

    }
#endif
    return isResult;
}

+ (void)cg_notificationAuthorizationStatusWithCompletionHandle:(void (^)(CGUNAuthorizationStatus))completion
{
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        UNAuthorizationStatus status = settings.authorizationStatus;
        CGUNAuthorizationStatus state   = CGUNAuthorizationStatusNotDetermined;
        switch (status) {
            case UNAuthorizationStatusDenied:
                state   = CGUNAuthorizationStatusDenied;
                break;
            case UNAuthorizationStatusAuthorized:
                state   = CGUNAuthorizationStatusAuthorized;
                break;
            default:
                
                break;
        }
        if (completion) {
            completion(state);
        }
    }];
}

@end
