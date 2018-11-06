//
//  CGDateDefineConstantsHeader.m
//  QuickAskCommunity
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 ym. All rights reserved.
//

#import "CGDateDefineConstantsHeader.h"

const NSCalendarUnit CGCalendarUnitAll  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

const NSCalendarUnit CGCalendarUnitYear = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

const NSCalendarUnit CGCalendarUnitTime = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

const CGFormatterStyle CGFormatterStyleYear = @"GMLFormatterStyleYear";
const CGFormatterStyle CGFormatterStyleTime = @"GMLFormatterStyleTime";
const CGFormatterStyle CGFormatterStyleAll = @"GMLFormatterStyleAll";
