//
//  CGDateDefineConstantsHeader.m
//  QuickAskCommunity
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 ym. All rights reserved.
//

#import "CGDateDefineConstantsHeader.h"

NSCalendarUnit const CGCalendarUnitAll  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

NSCalendarUnit const CGCalendarUnitYear = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

NSCalendarUnit const CGCalendarUnitTime = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

CGFormatterStyle const CGFormatterStyleYear = @"GMLFormatterStyleYear";
CGFormatterStyle const CGFormatterStyleTime = @"GMLFormatterStyleTime";
CGFormatterStyle const CGFormatterStyleAll = @"GMLFormatterStyleAll";
