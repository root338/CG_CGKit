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

@property (nullable, nonatomic, strong, readonly) UIPanGestureRecognizer *fullScreenPopGestureRecognizer;

///** 设置全屏回退手势，返回是否设置成功 */
- (BOOL)openFullScreenPopGestureRecognizer;
- (BOOL)closeFullScreenPopGestureRecognizer;

@end

@interface UINavigationController (CGPopAnimation)

@property (nonatomic, strong, nullable) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end
NS_ASSUME_NONNULL_END
