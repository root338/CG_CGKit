//
//  UIViewController+CGPropertyValue.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 快捷获取非 UIViewController 的属性值 */
@interface UIViewController (CGPropertyValue)

/** 状态栏是否隐藏 */
@property (nonatomic, assign, readonly) BOOL isStatusBarHidden;

@end

NS_ASSUME_NONNULL_END