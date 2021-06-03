//
//  UIView+CGSetupInteractivePopGestureRecognizerForNavigationController.m
//  TestCG_CGKit
//
//  Created by DY on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGSetupInteractivePopGestureRecognizerForNavigationController.h"

#import "UIView+CGSearchView.h"
// 注释原因：这个宏和项目是否添加该文件无关，只要在项目实体文件夹中就会通过
//#if __has_include("CGNavigationController.h")
//#import "CGNavigationController.h"
//#endif
@implementation UIView (CGSetupInteractivePopGestureRecognizerForNavigationController)

- (nullable UINavigationController *)getViewNavigationController
{
    return [self cg_searchViewControllerWithClass:[UINavigationController class]];
}

- (BOOL)setupNavigationControllerInteractivePopGestureRecognizerWithEnable:(BOOL)enable
{
    BOOL beforePopGestureRecognizerEnable           = NO;
    UINavigationController *navigationController    = [self getViewNavigationController];
//#if __has_include("CGNavigationController.h")
//    if ([navigationController isKindOfClass:[CGNavigationController class]]) {
//
//        CGNavigationController *navi        = (id)navigationController;
//        beforePopGestureRecognizerEnable    = navi.enablePopGestureRecognizer;
//        if (navi.enablePopGestureRecognizer != enable) {
//            navi.enablePopGestureRecognizer = enable;
//        }
//    }else
//#endif
    {
        
        beforePopGestureRecognizerEnable    = navigationController.interactivePopGestureRecognizer.enabled;
        if (navigationController.interactivePopGestureRecognizer.enabled != enable) {
            navigationController.interactivePopGestureRecognizer.enabled    = enable;
        }
    }
    return beforePopGestureRecognizerEnable;
}

#pragma mark - 设置属性
- (BOOL)enableInteractivePopGestureRecognizerForNavigationController
{
    return [self getViewNavigationController].interactivePopGestureRecognizer.enabled;
}

- (void)setEnableInteractivePopGestureRecognizerForNavigationController:(BOOL)enableInteractivePopGestureRecognizerForNavigationController
{
    [self getViewNavigationController].interactivePopGestureRecognizer.enabled  = enableInteractivePopGestureRecognizerForNavigationController;
}

@end
