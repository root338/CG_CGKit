//
//  CGNavigationDelegateObject.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/22.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGNavigationDelegateObject.h"

//视图类
#import "CGBaseNavigationController.h"

//具体功能类
#import "CGDefaultPopAnimation.h"

//视图扩展
#import "UINavigationController+CGSetupGestureRecognizer.h"

//协议
#import "CGNavigationAppearanceProtocol.h"

#import "CGPrintLogHeader.h"

@implementation CGNavigationDelegateObject

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController<CGNavigationAppearanceProtocol> *)viewController animated:(BOOL)animated
{
    CGDefaultLog();
    //设置导航栏显隐
    BOOL isShouldHidden = NO;
    if ([viewController respondsToSelector:@selector(cg_prefersNavigationBarHidden)]) {
        isShouldHidden  = [viewController cg_prefersNavigationBarHidden];
    }
    
    if (navigationController.navigationBarHidden != isShouldHidden) {
        [navigationController setNavigationBarHidden:isShouldHidden animated:animated];
    }
    
    //设置导航栏颜色
    if (!navigationController.navigationBarHidden) {
        
        UIColor *navigationBarBackground = nil;
        
        if ([viewController respondsToSelector:@selector(cg_prefersNavigationBarBackgroundColor)]) {
            navigationBarBackground = [viewController cg_prefersNavigationBarBackgroundColor];
        }else if ([navigationController isKindOfClass:[CGNavigationController class]]) {
            navigationBarBackground  = [(CGNavigationController *)navigationController defaultNavigationBarBackgroundColor];
        }else {
            navigationBarBackground  = navigationController.navigationBar.barTintColor;
        }
        
        if (![navigationBarBackground isEqual:navigationController.navigationBar.backgroundColor]) {
            navigationController.navigationBar.barTintColor  = navigationBarBackground;
        }
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController<CGNavigationAppearanceProtocol> *)viewController animated:(BOOL)animated
{
    CGDefaultLog();
    
}

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
