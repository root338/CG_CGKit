//
//  CGTimerButton.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGTimerButton.h"
#import "NSTimer+ChangeTimerStatus.h"

@interface CGTimerButton ()
{
    NSTimer *_timer;
    
    NSInteger currentTimerInterval;
    
    /** 计时前disable状态下的标题 */
    NSString *timerBeforeDisableTitle;
}

@property (assign, nonatomic, readwrite) BOOL isStringTimer;
@end

@implementation CGTimerButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)willMoveToWindow:(UIWindow *)newWindow
//{
//    [super willMoveToWindow:newWindow];
//    if (!newWindow) {
//
//    }
//}

#pragma mark - 计时器
- (void)startTimer
{
    if (self.isStringTimer) {
        return;
    }
    timerBeforeDisableTitle = [self titleForState:UIControlStateDisabled];
    currentTimerInterval = self.timerInterval;
    self.enabled = NO;
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(handleTimeMethod:)
                                                userInfo:nil
                                                 repeats:YES];
        
    }else {
        
        [_timer resumeTimer];
    }
    self.isStringTimer = YES;
}

- (void)pauseTimer
{
    if (self.isStringTimer) {
        self.isStringTimer = NO;
        self.enabled = YES;
        [self setTitle:timerBeforeDisableTitle forState:UIControlStateDisabled];
        timerBeforeDisableTitle = nil;
        [_timer pauseTimer];
    }
}

- (void)handleTimeMethod:(NSTimer *)paramTimer
{
    currentTimerInterval--;
    
    NSString *title = nil;
    if (self.timerCallback) {
        
        title = self.timerCallback(currentTimerInterval);
        
    }else if (self.titleForTimer) {
        
        NSString *timeStr = [NSString stringWithFormat:@"%li",(long)currentTimerInterval];
        title = [self.titleForTimer stringByReplacingOccurrencesOfString:@"[XX]" withString:timeStr];
    }
    
    !title ?: [self setTitle:title forState:UIControlStateDisabled];
    
    if (currentTimerInterval == 0) {
        [self pauseTimer];
    }
}

#pragma mark - 创建
+ (instancetype)timerButtonType:(UIButtonType)type timerInterval:(NSTimeInterval)timeInterval
{
    CGTimerButton *timerButton = [self buttonWithType:type];
    timerButton.timerInterval = timeInterval;
    return timerButton;
}
@end
