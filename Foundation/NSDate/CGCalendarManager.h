//
//  CGCalendarManager.h
//  QuickAskCommunity
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGDateDefineConstantsHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CGCalendarType) {
    
    CGCalendarTypeGregorian,
};

/**
 日历的偏移类型

 - CGCalendarOffsetTypeDay: 天数
 */
typedef NS_ENUM(NSInteger, CGCalendarOffsetType) {
    CGCalendarOffsetTypeDay,
};

@interface CGCalendarManager : NSObject

@property (class, readonly, strong) CGCalendarManager *defaultManager;

/// 创建的日历类型，默认CGCalendarTypeGregorian
@property (nonatomic, assign) CGCalendarType calendarType;
@property (nonatomic, strong, readonly) NSCalendar *calendar;

/**
 判断两个日期相差多少天

 @param fromDate 从什么日期开始
 @param toDate 到什么日期结束
 @return 返回差的天数
 */
- (NSInteger)dayWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 判断两个日期的偏差值

 @param unit 需要获取的单元
 @param fromDate 开始日期
 @param toDate 结束日记
 @return 返回偏差值结果
 */
- (nullable NSDateComponents *)components:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 对时间进行解析

 @param unit 得到时间需要的单元
 @param date 需要解析的时间
 @return 返回解析结果
 */
- (nullable NSDateComponents *)components:(NSCalendarUnit)unit date:(NSDate *)date;

#pragma mark - 格式化时间
- (nullable NSString *)date:(NSDate *)date formatterStyle:(CGFormatterStyle)formatterStyle;
- (nullable NSDate *)formatterString:(NSString *)formatterString style:(CGFormatterStyle)style;

@end

NS_ASSUME_NONNULL_END
