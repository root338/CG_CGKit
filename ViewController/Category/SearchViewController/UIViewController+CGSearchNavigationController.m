//
//  UIViewController+CGSearchNavigationController.m
//  QuickAskCommunity
//
//  Created by DY on 2017/4/28.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UIViewController+CGSearchNavigationController.h"

@implementation UIViewController (CGSearchNavigationController)

- (nullable __kindof UINavigationController *)searchNavigationController
{
    return [self searchNavigationControllerWithTargetClass:[UINavigationController class]];
}

- (nullable __kindof UINavigationController *)searchNavigationControllerWithTargetClass:(Class)targetNavigationControllerClassName
{
    if ([self isKindOfClass:targetNavigationControllerClassName]) {
        return (id)self;
    }else {
        if ([self.navigationController isKindOfClass:targetNavigationControllerClassName]) {
            return self.navigationController;
        }
        return [self.parentViewController searchNavigationControllerWithTargetClass:targetNavigationControllerClassName];
    }
}

- (nullable __kindof UINavigationController *)searchNavigationControllerWithMemberTargetClass:(Class)targetNavigationControllerClassName
{
    if ([self isMemberOfClass:targetNavigationControllerClassName]) {
        return (id)self;
    }else {
        if ([self.navigationController isMemberOfClass:targetNavigationControllerClassName]) {
            return self.navigationController;
        }
        return [self.parentViewController searchNavigationControllerWithTargetClass:targetNavigationControllerClassName];
    }
}

@end
