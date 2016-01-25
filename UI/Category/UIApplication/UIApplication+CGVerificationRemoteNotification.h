//
//  UIApplication+CGVerificationRemoteNotification.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (CGVerificationRemoteNotification)

/** 验证用户是否开启远程通知 */
+ (BOOL)cg_verifyUserOpenRemoteNotification;

@end
