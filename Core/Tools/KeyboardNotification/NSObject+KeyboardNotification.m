//
//  NSObject+KeyboardNotification.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+KeyboardNotification.h"
#import "NSObject+HandleNotificationStatus.h"

@implementation NSObject (KeyboardNotification)

- (NSArray *)keyboardShowHideNotificationNameArray
{
    return  @[
             UIKeyboardWillHideNotification,
             UIKeyboardWillShowNotification,
             ];
}

- (void)openKeyboardShowHideNotificationWithSelector:(SEL)selector
{
    
    [self notificationWithNames:[self keyboardShowHideNotificationNameArray]
                       isRemove:NO
                       observer:self
                       selector:selector
                         object:nil];
}

- (void)closeKeyboardShowHideNotificationWithSelector:(SEL)selector
{
    [self notificationWithNames:[self keyboardShowHideNotificationNameArray]
                       isRemove:YES
                       observer:self
                       selector:selector
                         object:nil];
}


@end
