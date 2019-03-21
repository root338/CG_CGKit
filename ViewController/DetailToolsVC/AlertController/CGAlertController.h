//
//  CGAlertController.h
//  TestCG_CGKit
//
//  Created by apple on 16/6/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGAlertController : UIAlertController

#pragma mark - 仅提示

/** 创建带取消按钮的提示 */
+ (instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message;


/** 弹层提示 (标题，内容，取消按钮) */
+ (instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(NSString *)cancelTitle;

/** 弹层提示 (标题，内容，取消按钮，其他按钮，回调) */
+ (nullable instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void ( ^ _Nullable)(BOOL isCancel))resultCallback;

/** 弹层提示 (标题，内容，取消按钮，其他按钮，其他按钮样式，回调) */
+ (nullable instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle otherTitleActionStyle:(UIAlertActionStyle)otherTitleActionStyle resultCallback:(void ( ^ _Nullable)(BOOL isCancel))resultCallback;

/** 弹层提示 (标题，内容，输入框, 设置输入框回调，取消按钮，其他按钮(数组)，回调) */
+ (instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message textInputsCount:(NSInteger)textInputsCount setupTextField:(void (^ __nullable) (UITextField *textField, NSInteger textFieldIndex))setupTextField cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray<NSString *> *)otherButtonTitles resultCallback:(void ( ^ _Nullable)(UIAlertAction * _Nonnull alertAction, NSArray<UITextField *> * _Nullable textFields))resultCallback;

/** 弹层提示 (弹层样式，标题，内容，取消按钮，其他按钮(数组)，回调) */
+ (instancetype)createAlertControllerWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray<NSString *> *)otherButtonTitles resultCallback:(void ( ^ _Nullable)(UIAlertAction *alertAction))resultCallback;

@end

NS_ASSUME_NONNULL_END
