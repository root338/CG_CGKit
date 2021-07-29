//
//  UIViewController+CGPushViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGPushViewController.h"
#import "UINavigationController+CGPushViewController.h"
#import "UIViewController+CGSearchNavigationController.h"

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
        
        topViewController = [self searchNavigationController].topViewController;
    }
    [self cgvc_pushViewController:viewController verifyCurrentTopViewController:topViewController animated:animated];
}

- (void)cgvc_pushViewController:(UIViewController *)viewController verifyCurrentTopViewController:(UIViewController *)currentTopViewController
{
    [self cgvc_pushViewController:viewController verifyCurrentTopViewController:currentTopViewController animated:!self.navigationController.disablePushHideAnimatied];
}

- (void)cgvc_pushViewController:(UIViewController *)viewController verifyCurrentTopViewController:(UIViewController *)currentTopViewController animated:(BOOL)animated
{
    [self cgvc_pushViewController:viewController verifyCurrentTopViewController:currentTopViewController animated:animated completion:nil];
}

- (void)cgvc_pushViewController:(UIViewController *)viewController verifyCurrentTopViewController:(UIViewController *)currentTopViewController animated:(BOOL)animated completion:(CGVCPushCallback)completion
{
    CGVCPushCallback callback = ^(BOOL isPush){
        
        if (completion) {
            completion(isPush);
        }
    };
    if (viewController == nil) {
        callback(NO);
        return;
    }
    if ((currentTopViewController == nil) || (currentTopViewController && self.navigationController.topViewController == currentTopViewController)) {
        
        [self.navigationController pushViewController:viewController animated:animated];
        callback(YES);
    }else {
        callback(NO);
    }
    
}

- (void)cgvc_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController
{
    [self cgvc_pushRemoveLastVCWithNewViewController:viewController animated:!self.navigationController.disablePushHideAnimatied];
}

- (void)cgvc_pushRemoveLastVCWithNewViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    !viewController?: [self.navigationController cg_pushRemoveLastVCWithNewViewController:viewController animated:animated];
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

@implementation UIViewController (CGPopViewController)

- (nullable UIViewController *)cgvc_popCurrentViewController
{
    return [self.navigationController cg_popCurrentViewController];
}

@end
