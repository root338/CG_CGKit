//
//  UIViewController+CGAlert.h
//  TestCG_CGKit
//
//  Created by apple on 16/6/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 显示提示视图 */
@interface UIViewController (CGAlert)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
/** 
 *  显示提示视图
 *  
 *  @return iOS 小于 8.0 返回CGAlertView ,大于等于8.0 返回CGAlertController
 */
- (UIAlertController *)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void (^ _Nullable)(BOOL isCancel))resultCallback;

#else 

/**
 *  显示提示视图
 *
 *  @return iOS 小于 8.0 返回CGAlertView ,大于等于8.0 返回CGAlertController
 */
- (CGAlertView *)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void (^ _Nullable)(BOOL isCancel))resultCallback;

#endif
@end

NS_ASSUME_NONNULL_END
