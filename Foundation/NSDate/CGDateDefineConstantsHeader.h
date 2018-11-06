//
//  CGDateDefineConstantsHeader.h
//  QuickAskCommunity
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString *CGFormatterStyle;


/// CG 中默认的需要的日期的属性：公元|年|月|日|时|分|秒
FOUNDATION_EXPORT const NSCalendarUnit CGCalendarUnitAll;
/// CG 中默认的需要的日期的属性：公元|年|月|日
FOUNDATION_EXPORT const NSCalendarUnit CGCalendarUnitYear;
/// CG 中默认的需要的日期的属性：时|分|秒
FOUNDATION_EXPORT const NSCalendarUnit CGCalendarUnitTime;


/// CG 中默认时间格式化：2018-01-01
FOUNDATION_EXPORT const CGFormatterStyle CGFormatterStyleYear;
/// CG 中默认时间格式化：时:分:秒
FOUNDATION_EXPORT const CGFormatterStyle CGFormatterStyleTime;
/// CG 中默认时间格式化：2018-01-01 时:分:秒
FOUNDATION_EXPORT const CGFormatterStyle CGFormatterStyleAll;
