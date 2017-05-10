////
////  NSDate+CGMLDateCategory.m
////  QuickAskCommunity
////
////  Created by DY on 2017/5/2.
////  Copyright © 2017年 ym. All rights reserved.
////
//
//#import "NSDate+CGMLDateCategory.h"
//
//#import <objc/runtime.h>
//
//extern NSMutableDictionary<NSNumber *, NSCalendar *> st *_calendarsDicForCGMLDate_C;
//
//@implementation NSDate (CGMLDateCategory)
//
//- (NSCalendar *)calendar
//{
//    NSNumber *key = @(self.calendarType);
//    NSCalendar *calendar = [_calendarsDicForCGMLDate_C objectForKey:key];
//    if (calendar == nil) {
//        
//        if (_calendarsDicForCGMLDate_C == nil) {
//            _calendarsDicForCGMLDate_C  = [NSMutableDictionary dictionary];
//        }
//        
//        calendar    = [self createCalendarWithType:self.calendarType];
//        
//        [_calendarsDicForCGMLDate_C setObject:calendar forKey:key];
//    }
//    
//    return calendar;
//}
//
//- (NSCalendar *)createCalendarWithType:(CGCalendarType)calendarType
//{
//    NSCalendar *calendar    = nil;
//    switch (calendarType) {
//        case CGCalendarTypeCurrentSystem:
//            calendar    = [NSCalendar currentCalendar];
//            break;
//        case CGCalendarTypeAutoUpdate:
//            calendar    = [NSCalendar autoupdatingCurrentCalendar];
//            break;
//    }
//    return calendar;
//}
//
//- (NSString *)stringWithUnit:(CGDateFormatUnit)unit
//{
//    NSDateComponents *dateComponents = [[self calendar] components:[self calendarUnitWithUnit:unit] fromDate:self];
//    
//    NSString *valueReturn   = nil;
//    
//    return valueReturn;
//}
//
//- (NSCalendarUnit)calendarUnitWithUnit:(CGDateFormatUnit)unit
//{
//    NSCalendarUnit calendarUnit = 0;
//    if (unit & CGDateFormatUnitEra) {
//        calendarUnit |= NSCalendarUnitEra;
//    }
//    
//    return calendarUnit;
//}
//
//#pragma mark - 设置属性
//
//- (void)setCalendarType:(CGCalendarType)type
//{
//    objc_setAssociatedObject(self, @selector(calendarType), @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (CGCalendarType)calendarType
//{
//    return [objc_getAssociatedObject(self, _cmd) integerValue];
//}
//
//@end
