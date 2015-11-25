//
//  NSObject+KeyboardNotification.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (KeyboardNotification)

/** 
 * 打开键盘即将显示和隐藏时的通知
 *
 * UIKeyboardWillHideNotification、UIKeyboardWillShowNotification
 */
- (void)openKeyboardShowHideNotificationWithSelector:(SEL)selector;

/**
 * 关闭键盘即将显示和隐藏时的通知
 *
 * UIKeyboardWillHideNotification、UIKeyboardWillShowNotification
 */
- (void)closeKeyboardShowHideNotificationWithSelector:(SEL)selector;



@end
