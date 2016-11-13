//
//  CGScrollViewDefineHeader.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/10.
//  Copyright © 2016年 ym. All rights reserved.
//

#ifndef CGScrollViewDefineHeader_h
#define CGScrollViewDefineHeader_h

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

/** 滑动控制类型 */
typedef NS_ENUM(NSInteger, CGScrollControlType) {
    /** 空 */
    CGScrollControlTypeNone,
    /** 手指还在屏幕滑动 */
    CGScrollControlTypeDragging,
    /** 手指离开屏幕，即将由惯性滑动 */
    CGScrollControlTypeEndDraggingWillDecelerating,
    /** 惯性滑动 */
    CGScrollControlTypeDecelerating,
};

#endif /* CGScrollViewDefineHeader_h */
