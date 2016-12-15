//
//  UIViewController+CGPushViewController.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGPushViewController)

/** 默认push视图控制器验证当前导航栏的topViewController */
@property (nonatomic, assign) BOOL disablePushVerifyCurrentTopViewController;

- (void)cgvc_pushViewController:(nullable UIViewController *)viewController;

- (void)cgvc_pushViewController:(nullable UIViewController *)viewController verifyCurrentTopViewController:(nullable UIViewController *)currentTopViewController;

- (void)cgvc_pushViewController:(nullable UIViewController *)viewController animated:(BOOL)animated;

- (void)cgvc_pushViewController:(nullable UIViewController *)viewController verifyCurrentTopViewController:(nullable UIViewController *)currentTopViewController animated:(BOOL)animated;

/** push视图控制器，删除最上层的视图控制器 */
- (void)cgvc_pushRemoveLastVCWithNewViewController:(nullable UIViewController *)viewController;
/** push视图控制器，删除最上层的视图控制器 */
- (void)cgvc_pushRemoveLastVCWithNewViewController:(nullable UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
