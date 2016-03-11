//
//  CGScrollViewDirectionHeader.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/10.
//  Copyright © 2016年 ym. All rights reserved.
//

#ifndef CGScrollViewDirectionHeader_h
#define CGScrollViewDirectionHeader_h

/**
 *  滑动的方向
 */
typedef NS_ENUM(NSInteger, CGScrollDirectionType) {
    /**
     *  未知
     */
    CGScrollDirectionTypeUnknown    = -1,
    /**
     *  静止
     */
    CGScrollDirectionTypeStop       = 0,
    /**
     *  向上
     */
    CGScrollDirectionTypeUp         = 1 << 0,
    /**
     *  向左
     */
    CGScrollDirectionTypeLeft       = 1 << 1,
    /**
     *  向下
     */
    CGScrollDirectionTypeDown       = 1 << 2,
    /**
     *  向右
     */
    CGScrollDirectionTypeRight      = 1 << 3,
    
    CGScrollDirectionTypeUpLeft     = CGScrollDirectionTypeUp   | CGScrollDirectionTypeLeft,
    CGScrollDirectionTypeUpRight    = CGScrollDirectionTypeUp   | CGScrollDirectionTypeRight,
    CGScrollDirectionTypeDownLeft   = CGScrollDirectionTypeDown | CGScrollDirectionTypeLeft,
    CGScrollDirectionTypeDownRight  = CGScrollDirectionTypeDown | CGScrollDirectionTypeRight,
};

#endif /* CGScrollViewDirectionHeader_h */
