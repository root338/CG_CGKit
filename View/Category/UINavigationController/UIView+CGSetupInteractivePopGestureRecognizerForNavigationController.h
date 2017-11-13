//
//  UIView+CGSetupInteractivePopGestureRecognizerForNavigationController.h
//  TestCG_CGKit
//
//  Created by DY on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGSetupInteractivePopGestureRecognizerForNavigationController)


/** 
 设置视图所在的导航栏的回退手势是否可用
 UINavigationController interactivePopGestureRecognizer 属性
 */
@property (nonatomic, assign) BOOL enableInteractivePopGestureRecognizerForNavigationController;

/** 设置视图所在的导航栏回退按钮的状态，返回之前的状态 */
- (BOOL)setupNavigationControllerInteractivePopGestureRecognizerWithEnable:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
