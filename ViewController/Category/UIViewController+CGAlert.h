//
//  UIViewController+CGAlert.h
//  TestCG_CGKit
//
//  Created by apple on 16/6/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CGAlertView;
/** 显示提示视图 */
@interface UIViewController (CGAlert)

- (UIAlertController *)showAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message textInputsCount:(NSInteger)textInputsCount setupTextField:(void (^ __nullable) (UITextField *textField, NSInteger textFieldIndex))setupTextField cancelTitle:(nullable NSString *)cancelTitle otherTitles:(nullable NSArray<NSString *> *)otherButtonTitles resultCallback:(void (NS_NOESCAPE ^ _Nullable)(UIAlertAction * _Nonnull alertAction, NSArray<UITextField *> * _Nullable textFields))resultCallback NS_AVAILABLE_IOS(8_0);

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0


- (UIAlertController *)showAlertViewWithMessage:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle;

/** 
 *  显示提示视图
 *  
 *  @return iOS 小于 8.0 返回CGAlertView ,大于等于8.0 返回CGAlertController
 */
- (UIAlertController *)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void (NS_NOESCAPE ^ _Nullable)(BOOL isCancel))resultCallback;

- (UIAlertController *)showAlertViewWithTitle:(NSString *)title message:(NSString *)message otherTitle1:(NSString *)otherTitle1 otherTitle2:(NSString *)otherTitle2 resultCallback:(void (NS_NOESCAPE ^)(NSInteger index))resultCallback;

#else 

- (id)showAlertViewWithMessage:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle;

/**
 *  显示提示视图
 *
 *  @return iOS 小于 8.0 返回CGAlertView ,大于等于8.0 返回CGAlertController
 */
- (id)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void (NS_NOESCAPE ^ _Nullable)(BOOL isCancel))resultCallback;

- (id)showAlertViewWithTitle:(NSString *)title message:(NSString *)message otherTitle1:(NSString *)otherTitle1 otherTitle2:(NSString *)otherTitle2 resultCallback:(void (NS_NOESCAPE ^)(NSInteger index))resultCallback;

#endif
@end

NS_ASSUME_NONNULL_END
