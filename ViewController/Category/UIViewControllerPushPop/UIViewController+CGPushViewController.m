//
//  UIViewController+CGPushViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGPushViewController.h"
#import "UINavigationController+CGPushViewController.h"

#import <objc/runtime.h>

@implementation UIViewController (CGPushViewController)

- (void)cgvc_pushViewController:(UIViewController *)viewController
{
    [self cgvc_pushViewController:viewController animated:!self.navigationController.disablePushHideAnimatied];
}

- (void)cgvc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *topViewController = nil;
    if (!self.disablePushVerifyCurrentTopViewController) {
        topViewController   = self;
    }
    [self cgvc_pushViewController:viewController verifyCurrentTopViewController:topViewController animated:animated];
}

- (void)cgvc_pushViewController:(UIViewController *)viewController verifyCurrentTopViewController:(UIViewController *)currentTopViewController
{
    [self cgvc_pushViewController:viewController verifyCurrentTopViewController:currentTopViewController animated:!self.navigationController.disablePushHideAnimatied];
}

- (void)cgvc_pushViewController:(UIViewController *)viewController verifyCurrentTopViewController:(UIViewController *)currentTopViewController animated:(BOOL)animated
{
    if (viewController == nil) {
        return;
    }
    if ((currentTopViewController == nil) || (currentTopViewController && self.navigationController.topViewController == currentTopViewController)) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (void)cgvc_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController
{
    [self cgvc_pushRemoveLastVCWithNewViewController:viewController animated:!self.navigationController.disablePushHideAnimatied];
}

- (void)cgvc_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != nil && self.navigationController.topViewController == self) {
        [self.navigationController cg_pushRemoveLastVCWithNewViewController:viewController animated:animated];
    }
}

#pragma mark - 设置属性

- (void)setDisablePushVerifyCurrentTopViewController:(BOOL)disable
{
    objc_setAssociatedObject(self, @selector(disablePushVerifyCurrentTopViewController), @(disable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)disablePushVerifyCurrentTopViewController
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
