//
//  CGDateConstantHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/14.
//  Copyright © 2015年 ym. All rights reserved.
//

#ifndef CGDateConstantHeader_h
#define CGDateConstantHeader_h

#import <Foundation/Foundation.h>

#pragma mark - 定义枚举
/**
 *  字符串的指定样式
 */
typedef NS_ENUM(NSInteger, CGDateForStringFormatter){
    /**
     *  默认样式 yyyy_MM_dd HH_mm_ss
     */
    CGDateForStringFormatterDefault,
    /**
     *  年 yyyy_MM_dd
     */
    CGDateForStringFormatterYear,
    /**
     *  时间 HH_mm_ss
     */
    CGDateForStringFormatterTimer,
};

#pragma mark - 定义常量
const NSCalendarUnit unit_yyyy_mm_dd = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
const NSCalendarUnit unit_hh_mm_ss   = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
const NSCalendarUnit unit_yyyy_mm_dd_hh_mm_ss = unit_yyyy_mm_dd | unit_hh_mm_ss;
const NSCalendarUnit unit_yearAndWeek = unit_yyyy_mm_dd | NSCalendarUnitWeekday;





#endif /* CGDateConstantHeader_h */
