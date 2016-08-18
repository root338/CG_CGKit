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

- (void)cg_pushViewController:(UIViewController *)viewController;

- (void)cg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/** push视图控制器，删除最上层的视图控制器 */
- (void)cg_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController;
/** push视图控制器，删除最上层的视图控制器 */
- (void)cg_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END