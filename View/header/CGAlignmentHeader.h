//
//  CGAlignmentHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#ifndef QuickAskCommunity_CGAlignmentHeader_h
#define QuickAskCommunity_CGAlignmentHeader_h

/** 一些对齐变量的声明 */

#import <UIKit/UIKit.h>

/**
 *  水平对齐模式
 */
typedef NS_ENUM(NSInteger, CGViewHorizontalAlignment){
    /**
     *  水平左对齐
     */
    CGViewAlignmentHorizontalLeft,
    /**
     *  水平居中对齐
     */
    CGViewAlignmentHorizontalCenter,
    /**
     *  水平右对齐
     */
    CGViewAlignmentHorizontalRight,
};

/**
 *  垂直对齐
 */
typedef NS_ENUM(NSInteger, CGViewVerticalAlignment){
    /**
     *  居顶
     */
    CGViewVerticalAlignmentTop,
    /**
     *  垂直居中对齐
     */
    CGViewVerticalAlignmentCenter,
    /**
     *  居底
     */
    CGViewVerticalAlignmentBottom,
};

/**
 *  视图的位置属性
 */
typedef NS_ENUM(NSInteger, CGViewPositionStyle) {
    /**
     *  上面
     */
    CGViewPositionStyleTop,
    /**
     *  左边
     */
    CGViewPositionStyleLeft,
    /**
     *  下边
     */
    CGViewPositionStyleBottom,
    /**
     *  右边
     */
    CGViewPositionStyleRight,
};
#endif
