//
//  YMAlertView.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/14.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_CLASS_DEPRECATED_IOS(2_0, 9_0, "UIAlertView is deprecated") __TVOS_PROHIBITED
@interface CGAlertView : UIAlertView

/** delegate设置为自身时回调block */
@property (nonatomic, copy) void (^clickCallback) (BOOL isCancel, NSInteger tag);

#pragma mark - 可选择提示，根据用户选择执行回调
/**
 *  创建UIAlertView并自动弹出，设置（标题，内容）
 *  @see                  默认按钮设置为确定、取消，根据选择回调
 *
 *  @param title          标题
 *  @param message        内容
 *  @param resultCallback 回调方法（回调是否点击了取消按钮）
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message resultCallback:(void (^)(BOOL isCancel))resultCallback;

/**
 *  创建UIAlertView并自动弹出，设置（标题，内容，取消按钮，其他按钮）
 *  @see 根据用户选择回调
 *
 *  @param title            标题
 *  @param message          内容
 *  @param cancelTitle      取消按钮名
 *  @param otherButtonTitle 其他按钮名
 *  @param resultCallback   点击后的回调方法（回调是否点击了取消按钮）
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle otherTitle:(NSString *)otherButtonTitle resultCallback:(void (^)(BOOL isCancel))resultCallback;

/**
 创建UIAlertView并自动弹出，设置（标题，内容，其他按钮, 其他按钮2）
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message otherTitle1:(NSString *)title1 otherTitle2:(NSString *)title2 resultCallback:(void (^) (NSInteger index))resultCallback;

///**
// *  创建UIAlertView并自动弹出，设置（标题，内容，取消按钮，其他按钮（多个））
// *
// *  @param title          标题
// *  @param message        内容
// *  @param cancelTitle    取消按钮名
// *  @param resultCallback 点击后的回调方法
// *  @param otherTitle     其他按钮名（多个）
// *
// *  @return 返回创建好的UIAlertView
// */
//+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle resultCallback:(void (^)(BOOL isCancel, NSInteger clickInteger))resultCallback otherTitles:(NSString *)otherTitle, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - 仅提示，有标题和内容
/**
 *  创建UIAlertView并自动弹出，设置（内容）
 *  @see           默认按钮仅有确定按钮，标题为“通知”，仅提示没有回调
 *
 *  @param message 内容
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithNoteMessage:(NSString *)message;

/**
 *  创建UIAlertView并自动弹出，设置（内容，内容）
 *  @see 默认按钮仅有确定按钮，仅提示没有回调
 *
 *  @param title   标题
 *  @param message 内容
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  创建UIAlertView并自动弹出，设置（内容，取消按钮名称）
 *  @see 默认标题为“通知”，仅提示没有回调
 *
 *  @param message     内容
 *  @param cancelTitle 取消按钮的名称
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithNoteMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;

/** 创建UIAlertView并自动弹出，设置（标题，内容，取消按钮名称） */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle;

#pragma mark - 仅提示，无标题
/**
 *  创建UIAlertView并自动弹出，设置（内容）
 *  @see           默认按钮仅有确定按钮，无标题，仅提示没有回调
 *
 *  @param message 内容
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithOnlyMessage:(NSString *)message;

/**
 *  创建UIAlertView并自动弹出，设置（内容，取消按钮名称）
 *  @see 无标题，仅提示没有回调
 *
 *  @param message     内容
 *  @param cancelTitle 取消按钮
 *
 *  @return 返回创建好的UIAlertView
 */
+ (instancetype)showAlertViewWithOnlyMessage:(NSString *)message cancelTitle:(NSString *)cancelTitle;
@end

