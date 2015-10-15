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

const NSCalendarUnit unit_yyyy_mm_dd = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
const NSCalendarUnit unit_hh_mm_ss   = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
const NSCalendarUnit unit_yyyy_mm_dd_hh_mm_ss = unit_yyyy_mm_dd | unit_hh_mm_ss;
const NSCalendarUnit unit_yearAndWeek = unit_yyyy_mm_dd | NSCalendarUnitWeekday;

#endif /* CGDateConstantHeader_h */
