//
//  NSNotification+CGKeyboardUserInfo.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 键盘通知时使用，获取键盘的参数值 */
@interface NSNotification (CGKeyboardUserInfo)

/** 键盘的CGRect，获取的是UIKeyboardFrameEndUserInfoKey值 */
@property (nonatomic, assign, readonly) CGRect keyboardFrame;

@property (nonatomic, assign, readonly) NSTimeInterval keyboardDuration;

@property (nonatomic, assign, readonly) NSUInteger keyboardCurve;


@end

NS_ASSUME_NONNULL_END