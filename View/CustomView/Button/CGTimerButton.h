//
//  CGTimerButton.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseButton.h"

/** 设置按钮计时 */
@interface CGTimerButton : CGBaseButton

/** 是否已经开始计时 */
@property (assign, nonatomic, readonly) BOOL isStringTimer;

/** 计时总时间 */
@property (assign, nonatomic) NSTimeInterval timerInterval;

#pragma mark - 计时期间标题的设置
/** 计时期间的标题（用字符"[XX]"代表数字,期间自动替换） */
@property (strong, nonatomic) NSString *titleForTimer;

/** 计时期间的标题的颜色 */
//@property (strong, nonatomic) UIColor *titleColorForTimer;

/** 每次计时回调的block */
@property (copy, nonatomic) NSString * (^timerCallback) (NSInteger currentTimerInterval);

/** 开始计时 */
- (void)startTimer;
/** 暂停计时 */
- (void)pauseTimer;

+ (instancetype)timerButtonType:(UIButtonType)type timerInterval:(NSTimeInterval)timeInterval;
@end
