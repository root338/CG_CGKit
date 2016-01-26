//
//  NSObject+KeyboardNotification.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KeyboardNotification)

/** 
 * 打开键盘即将显示和隐藏时的通知
 *
 * UIKeyboardWillHideNotification、UIKeyboardWillShowNotification
 */
- (void)openKeyboardShowHideNotificationWithSelector:(SEL)selector NS_DEPRECATED_IOS(4_0, 9_0, "Use +cg_addKeyboardObserver:selector:");

/**
 * 关闭键盘即将显示和隐藏时的通知
 *
 * UIKeyboardWillHideNotification、UIKeyboardWillShowNotification
 */
- (void)closeKeyboardShowHideNotificationWithSelector:(SEL)selector NS_DEPRECATED_IOS(4_0, 9_0, "Use +cg_removeKeyboardObserver:");

@end
NS_ASSUME_NONNULL_END