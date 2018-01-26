//
//  CGCalendarManager.m
//  QuickAskCommunity
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 ym. All rights reserved.
//

/**
 
 参考链接： http://nshipster.cn/nscalendar-additions/
 */

#import "CGCalendarManager.h"

const NSCalendarUnit CGCalendarUnitAll  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

const NSCalendarUnit CGCalendarUnitYear = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

const NSCalendarUnit CGCalendarUnitTime = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

@interface CGCalendarManager ()

@property (nonatomic, strong, readwrite) NSCalendar *calendar;

@end

@implementation CGCalendarManager

+ (CGCalendarManager *)defaultManager {
    
    static CGCalendarManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (NSInteger)dayWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    return [self components:NSCalendarUnitDay fromDate:fromDate toDate:toDate].day;
}

- (NSDateComponents *)components:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSDateComponents *dateComponents = [self.calendar components:unit fromDate:fromDate toDate:toDate options:NSCalendarMatchStrictly];
    return dateComponents;
}

- (NSDateComponents *)components:(NSCalendarUnit)unit date:(NSDate *)date
{
    NSDateComponents *dateComponents = [self.calendar components:unit fromDate:date];
    return dateComponents;
}

#pragma mark - 私有方法
- (NSCalendarIdentifier)calendarIdentifier
{
    NSCalendarIdentifier identifier = nil;
    switch (self.calendarType) {
        
        case CGCalendarTypeGregorian:
            identifier  = NSCalendarIdentifierGregorian;
            break;
    }
    
    return identifier ? identifier : NSCalendarIdentifierGregorian;
}

#pragma mark - 设置属性

- (void)setCalendarType:(CGCalendarType)calendarType
{
    if (_calendarType != calendarType) {
        _calendarType   = calendarType;
        _calendar       = nil;
    }
}

- (NSCalendar *)calendar
{
    if (_calendar) {
        return _calendar;
    }
    
    _calendar = [NSCalendar calendarWithIdentifier:[self calendarIdentifier]];;
    
    return _calendar;
}

@end
