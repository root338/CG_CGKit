//
//  NSNotification+CGKeyboardUserInfo.m
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSNotification+CGKeyboardUserInfo.h"

@implementation NSNotification (CGKeyboardUserInfo)

#pragma mark - 设置属性

- (CGRect)keyboardFrame
{
    CGRect keyboardFrame;
    keyboardFrame   = [[self.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    return keyboardFrame;
}

- (NSTimeInterval)keyboardDuration
{
    return [[self.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
}

- (NSUInteger)keyboardCurve
{
    return [[self.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] floatValue];
}
@end
