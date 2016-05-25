//
//  NSTimer+ChangeTimerStatus.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 修改计时器 */
@interface NSTimer (ChangeTimerStatus)

/** 暂停计时器 */
- (void)pauseTimer;
/** 继续执行计时器 */
- (void)resumeTimer;

/** 停止计时器 */
- (void)stopTimer;
/** 在多少秒之后继续执行计时器 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
NS_ASSUME_NONNULL_END