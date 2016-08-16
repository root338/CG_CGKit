//
//  UINavigationController+CGSetupGestureRecognizer.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationController.h"


NS_ASSUME_NONNULL_BEGIN
@interface UINavigationController (CGSetupGestureRecognizer)

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fullScreenPopGestureRecognizer;

///** 设置全屏回退手势 */
- (void)cg_openFullScreenPopGestureRecognizer;
@end

@interface UINavigationController (CGPopAnimation)

@property (nonatomic, strong, nullable) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end
NS_ASSUME_NONNULL_END