//
//  NSTimer+ChangeTimerStatus.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSTimer (ChangeTimerStatus)

- (void)pauseTimer;
- (void)resumeTimer;

- (void)stopTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
NS_ASSUME_NONNULL_END