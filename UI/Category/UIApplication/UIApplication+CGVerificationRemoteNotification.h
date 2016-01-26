//
//  UIApplication+CGVerificationRemoteNotification.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIApplication (CGVerificationRemoteNotification)

/** 验证用户是否开启远程通知 */
+ (BOOL)cg_verifyUserOpenRemoteNotification;

@end
NS_ASSUME_NONNULL_END