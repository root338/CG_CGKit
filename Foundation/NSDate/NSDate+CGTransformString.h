//
//  NSDate+CGTransformString.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGDateConstantHeader.h"



/** 时间转换 */
@interface NSDate (CGTransformString)

#pragma mark - 根据时区重置时间

/** 根据系统默认时区，重置时间 */
- (NSDate *)offsetDefaultTimeZone;

/**
 *  根据指定时区，重置时间
 *
 *  @param timeZone 指定时区
 *
 *  @return 返回重置后的时间
 */
- (NSDate *)offsetWithTimeZone:(NSTimeZone *)timeZone;

#pragma mark - 时间转换
/**
 *  将时间转换为指定的格式字符串
 *
 *  @param stringFormatter 字符串样式
 *
 *  @return 返回结果样式字符串
 */
- (NSString *)transformStringWithFormatter:(CGDateForStringFormatter)stringFormatter;


@end
