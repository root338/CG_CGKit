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

#endif /* CGDateConstantHeader_h */
