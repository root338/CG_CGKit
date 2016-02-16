//
//  CGNavigationDelegateObject.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/22.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGNavigationDelegateObject.h"

//具体功能类
#import "CGDefaultPopAnimation.h"

//视图扩展
#import "UIViewController+CGFullscreenPopGesture.h"
#import "UINavigationController+CGSetupGestureRecognizer.h"

//协议
#import "CGNavigationAppearanceProtocol.h"

#import "CGPrintLogHeader.h"

@implementation CGNavigationDelegateObject

#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController<CGNavigationAppearanceProtocol> *)viewController animated:(BOOL)animated
//{
//    
//}

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController<CGNavigationAppearanceProtocol> *)viewController animated:(BOOL)animated
//{
//    
//}

//- (nullable id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    if ([animationController isKindOfClass:[CGDefaultPopAnimation class]]) {
//        return navigationController.interactivePopTransition;
//    }
//    return nil;
//}
//
//- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
//{
//    if (operation == UINavigationControllerOperationPop) {
//        return [[CGDefaultPopAnimation alloc] init];
//    }
//    return nil;
//}

@end
