//
//  NSNotification+CGKeyboardUserInfo.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

/** 键盘通知时使用，获取键盘的参数值 */
@interface NSNotification (CGKeyboardUserInfo)

/** 键盘的CGRect，获取的是UIKeyboardFrameEndUserInfoKey值 
 *  会进行简单的判断处理，iOS 9，10 后有时键盘的 CGPoint 的值是从顶部掉下，这时Y值会变成相当大的负数从而导致计算的值出现bug，这时会自动修改keyboard的CGPoint值，为屏幕底部
 */
@property (nonatomic, assign, readonly) CGRect keyboardFrame;

/** UIKeyboardFrameEndUserInfoKey 键值的 CGRect 值 */
@property (nonatomic, assign, readonly) CGRect keyboardFrameEndUserInfoKey;

@property (nonatomic, assign, readonly) NSTimeInterval keyboardDuration;

@property (nonatomic, assign, readonly) NSUInteger keyboardCurve;


@end

NS_ASSUME_NONNULL_END
