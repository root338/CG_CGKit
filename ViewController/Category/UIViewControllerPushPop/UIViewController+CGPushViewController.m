//
//  UIViewController+CGPushViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGPushViewController.h"
#import "UINavigationController+CGPushViewController.h"

@implementation UIViewController (CGPushViewController)

- (void)cg_pushViewController:(UIViewController *)viewController
{
    [self cg_pushViewController:viewController animated:!self.navigationController.defaultPushHideAnimatied];
}

- (void)cg_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.navigationController.topViewController == self) {
        [self.navigationController cg_pushViewController:viewController animated:animated];
    }
}

- (void)cg_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController
{
    [self cg_pushRemoveLastVCWithNewViewController:viewController animated:!self.navigationController.defaultPushHideAnimatied];
}

- (void)cg_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.navigationController.topViewController == self) {
        [self.navigationController cg_pushRemoveLastVCWithNewViewController:viewController animated:animated];
    }
}

@end
