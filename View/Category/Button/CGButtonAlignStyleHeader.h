//
//  CGButtonAlignStyleHeader.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#ifndef CGButtonAlignStyleHeader_h
#define CGButtonAlignStyleHeader_h

/**
 *  设置按钮标题与图片的对齐方式
 */
typedef NS_ENUM(NSInteger, CGButtonStyle) {
    /**
     *  水平对齐，标题居左
     */
    CGButtonStyleHorizonalLeft,
    /**
     *  水平对齐，标题居右
     */
    CGButtonStyleHorizonalRight,
    /**
     *  垂直对齐，标题居上
     */
    CGButtonStyleVerticalTop,
    /**
     *  垂直对齐，标题居下
     */
    CGButtonStyleVerticalBottom,
};

/**
 *  标题、图像的对齐方式
 */
typedef NS_ENUM(NSInteger, CGButtonContentAlignment) {
    /**
     *  居中
     */
    CGButtonContentAlignmentCenter,
    /**
     *  顶部对齐
     *  CGButtonStyleHorizonalLeft, CGButtonStyleHorizonalRight 下有效
     */
    CGButtonContentAlignmentTop,
    /**
     *  左对齐
     *  CGButtonStyleVerticalTop, CGButtonStyleVerticalBottom 下有效
     */
    CGButtonContentAlignmentLeft,
    /**
     *  底部对齐
     *  CGButtonStyleHorizonalLeft, CGButtonStyleHorizonalRight 下有效
     */
    CGButtonContentAlignmentBottom,
    /**
     *  右对齐
     *  CGButtonStyleVerticalTop, CGButtonStyleVerticalBottom 下有效
     */
    CGButtonContentAlignmentRight,
};

#endif /* CGButtonAlignStyleHeader_h */
