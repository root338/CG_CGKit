//
//  CGTimeManager.h
//  QuickAskCommunity
//
//  Created by DY on 2017/9/19.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 日历的类型 */
typedef NS_ENUM(NSInteger, CGCalendarType) {
    
    /** 系统当前日历类型 [NSCalendar currentCalendar] */
    CGCalendarTypeSystem,
    /** 使用公元历 */
    CGCalendarTypeGregorian,
};

@interface CGTimeManager : NSObject

+ (instancetype)defaultManager;

/** 日历的类型, 默认 CGCalendarTypeSystem */
@property (nonatomic, assign) CGCalendarType calendarType;

@end

NS_ASSUME_NONNULL_END
