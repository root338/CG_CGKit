//
//  CGNavigationDelegateObject.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/22.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGNavigationDelegateObject.h"
//#import "PopAnimation.h"
#import "CGBaseNavigationController.h"

@implementation CGNavigationDelegateObject


#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

//- (nullable id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
//{
//    if ([animationController isKindOfClass:[PopAnimation class]]) {
//        return [(id)navigationController interactiveTransition];
//    }
//    return nil;
//}

//- (nullable id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
//{
//    if (operation == UINavigationControllerOperationPop) {
//        return [[PopAnimation alloc] init];
//    }
//    return nil;
//}

@end
