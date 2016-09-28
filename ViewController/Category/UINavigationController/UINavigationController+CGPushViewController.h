//
//  UINavigationController+CGPushViewController.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 弹出视图控制器的扩展 */
@interface UINavigationController (CGPushViewController)

/** 默认push视图控制器隐藏动画，默认值为 NO */
@property (nonatomic, assign) BOOL disablePushHideAnimatied;

/** push视图控制器 */
- (void)cg_pushViewController:(UIViewController *)viewController;

/** push视图控制器，删除最上层的视图控制器 */
- (void)cg_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController;
/** push视图控制器，删除最上层的视图控制器 */
- (void)cg_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController animated:(BOOL)animated;

/** push视图控制器，且删除指定视图控制器 */
- (void)cg_pushViewController:(UIViewController *)viewController removeViewControllers:(NSArray<UIViewController *> *)viewControllers;
/** push视图控制器，且删除指定视图控制器 */
- (void)cg_pushViewController:(UIViewController *)viewController removeViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;

/** push视图控制器，且删除指定类下的所有视图控制器 */
- (void)cg_pushViewController:(UIViewController *)viewController removeViewControllerClass:(NSArray<Class> *)viewControllerClass;
/** push视图控制器，且删除指定类下的所有视图控制器 */
- (void)cg_pushViewController:(UIViewController *)viewController removeViewControllerClass:(NSArray<Class> *)viewControllerClass animated:(BOOL)animated;

@end


NS_ASSUME_NONNULL_END
