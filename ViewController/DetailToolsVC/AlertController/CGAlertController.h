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


+ (instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(NSString *)cancelTitle;


/**
 *  创建CGAlertController提示视图
 *
 *  @param title            标题
 *  @param message          提示文本
 *  @param cancelTitle      取消按钮标题
 *  @param otherButtonTitle 其他按钮标题
 *  @param resultCallback   点击的回调
 *
 */
+ (nullable instancetype)createAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void (^ _Nullable)(BOOL isCancel))resultCallback;

+ (nullable instancetype)createAlertControllerWithPreferredStyle:(UIAlertControllerStyle)preferredStyle title:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray<NSString *> *)otherButtonTitles resultCallback:(void (^ _Nullable)(UIAlertAction *alertAction))resultCallback;

@end

NS_ASSUME_NONNULL_END
