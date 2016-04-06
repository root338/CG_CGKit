//
//  UIApplication+CGVerificationRemoteNotification.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIApplication+CGVerificationRemoteNotification.h"
#import "CGVerifyIOSVersionHeader.h"

@implementation UIApplication (CGVerificationRemoteNotification)

+ (BOOL)cg_verifyUserOpenRemoteNotification
{
    BOOL isResult;
    
    UIApplication *application = [UIApplication sharedApplication];
    if (_CG_IOS_8_0_AFTER) {
        
        UIUserNotificationSettings *settings = [application currentUserNotificationSettings];
        isResult = (settings.types != UIUserNotificationTypeNone);
    }else {
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_8_0
        UIRemoteNotificationType type = [application enabledRemoteNotificationTypes];
        isResult = (type != UIRemoteNotificationTypeNone);
#endif
    }
    return isResult;
}

@end