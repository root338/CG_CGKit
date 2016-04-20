//
//  NSDate+CGTransformString.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSDate+CGTransformString.h"

@implementation NSDate (CGTransformString)

- (NSDate *)offsetDefaultTimeZone
{
    return [self offsetWithTimeZone:[NSTimeZone systemTimeZone]];
}

- (NSDate *)offsetWithTimeZone:(NSTimeZone *)timeZone
{
    NSTimeInterval offsetTimeInterval = [timeZone secondsFromGMTForDate:self];
    NSDate *newDate = [self dateByAddingTimeInterval:offsetTimeInterval];
    return newDate;
}

- (NSString *)transformStringWithFormatter:(CGDateForStringFormatter)stringFormatter
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponent = [calendar components:unit_yyyy_mm_dd_hh_mm_ss
                                                  fromDate:self];
    
    NSString *formatterStr = nil;
    switch (stringFormatter) {
        case CGDateForStringFormatterDefault:
            formatterStr = [NSString stringWithFormat:@"%04li-%02li-%02li %02li:%02li-%02li", (long)dateComponent.year, (long)dateComponent.month, (long)dateComponent.day, (long)dateComponent.hour, (long)dateComponent.minute, (long)dateComponent.second];
            break;
        case CGDateForStringFormatterTimer:
            formatterStr = [NSString stringWithFormat:@"%02li:%02li-%02li", (long)dateComponent.hour, (long)dateComponent.minute, (long)dateComponent.second];
            break;
        case CGDateForStringFormatterYear:
            formatterStr = [NSString stringWithFormat:@"%04li-%02li-%02li", (long)dateComponent.year, (long)dateComponent.month, (long)dateComponent.day];
            break;
        default:
            break;
    }
    
    return formatterStr;
}

@end
