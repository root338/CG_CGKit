//
//  CGTimeManager.m
//  QuickAskCommunity
//
//  Created by DY on 2017/9/19.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "CGTimeManager.h"

@interface CGTimeManager ()
{
    NSCalendar *_calendar;
}
@end

@implementation CGTimeManager

+ (instancetype)defaultManager
{
    static CGTimeManager *timeManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeManager = [[CGTimeManager alloc] init];
    });
    return timeManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.calendarType   = CGCalendarTypeSystem;
    }
    return self;
}

@end
