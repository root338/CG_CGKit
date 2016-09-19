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


/** 
 *  显示提示视图
 *  
 *  @return iOS 小于 8.0 返回CGAlertView ,大于等于8.0 返回CGAlertController
 */
- (id)showAlertViewWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle otherTitle:(nullable NSString *)otherButtonTitle resultCallback:(void (^ _Nullable)(BOOL isCancel))resultCallback;

@end

NS_ASSUME_NONNULL_END
