//
//  CGKeyboardManagerHeader.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/27.
//  Copyright © 2016年 ym. All rights reserved.
//

#ifndef CGKeyboardManagerHeader_h
#define CGKeyboardManagerHeader_h

/** 键盘的通知类型 */
typedef NS_ENUM(NSInteger, CGKeyboardNotificationType) {
    
    CGKeyboardNotificationTypeNone,
    CGKeyboardNotificationTypeWillShow,
    CGKeyboardNotificationTypeDidShow,
    CGKeyboardNotificationTypeWillHide,
    CGKeyboardNotificationTypeDidHide,
};

/** 默认设置下修改frame的类型 */
typedef NS_ENUM(NSInteger, CGKeyboardChangeFrameType) {
    
    /** 修改CGSize */
    CGKeyboardChangeFrameTypeSize,
    /** 修改CGPoint */
    CGKeyboardChangeFrameTypeOrigin,
    /** 修改视图的中心坐标 */
    CGKeyboardChangeFrameTypeCenter,
};

/** 键盘布局的类型 */
typedef NS_ENUM(NSInteger, CGKeyboardLayoutType) {
    /** 自动设置 */
    CGKeyboardLayoutTypeAuto,
    /** 使用约束设置  */
    CGKeyboardLayoutTypeLayout,
    /** 自动布局 */
    CGKeyboardLayoutTypeAutomaticLayout,
};

#endif /* CGKeyboardManagerHeader_h */
