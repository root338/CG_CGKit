//
//  UIViewController+CGFullscreenPopGesture.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGFullscreenPopGesture.h"
#import <objc/runtime.h>

#import "CGNavigationController.h"

#import "NSObject+CGExchangeSelector.h"

#import "CGNavigationAppearanceProtocol.h"

/**
 *  配合CGNavigationController对导航栏的设置
 */
@interface UIViewController (CGSetupNavigationBar)

/** 设置导航栏的外观 */
- (void)cg_setupNavigationBarAppearance;

/** 设置视图控制器的导航栏颜色 */
- (void)cg_setupNavigationBarBackgroundColor;

/** 设置视图控制器的导航栏是否隐藏 */
- (void)cg_setupNavigationBarHiddenWithAnimation:(BOOL)animated;

/** 设置视图控制器的导航栏标题样式 */
- (void)cg_setupNavigationBarTitleTextAttributes;
@end

@implementation UIViewController (CGSetupNavigationBar)

- (void)cg_setupNavigationBarAppearance
{
    [self cg_setupNavigationBarBackgroundColor];
    [self cg_setupNavigationBarTitleTextAttributes];
}

- (void)cg_setupNavigationBarBackgroundColor
{
    
    UINavigationController *navigationController = self.navigationController;
    //设置导航栏颜色
    if (!navigationController.navigationBarHidden) {
        
        UIViewController<CGNavigationAppearanceProtocol> * viewController = (id)self;
        
        UIColor *navigationBarBackground = nil;
        
        if ([viewController respondsToSelector:@selector(cg_prefersNavigationBarBackgroundColor)]) {
            //获取CGNavigationAppearanceProtocol协议的cg_prefersNavigationBarBackgroundColor的颜色值
            navigationBarBackground = [viewController cg_prefersNavigationBarBackgroundColor];
        }else if ([navigationController isKindOfClass:[CGNavigationController class]]) {
            //当视图控制器的导航栏为CGNavigationController时，获取默认的导航栏颜色
            navigationBarBackground  = [(CGNavigationController *)navigationController defaultNavigationBarBackgroundColor];
        }
        
        if (navigationBarBackground && ![navigationBarBackground isEqual:navigationController.navigationBar.barTintColor]) {
            
            navigationController.navigationBar.barTintColor  = navigationBarBackground;
        }
    }
}

- (void)cg_setupNavigationBarTitleTextAttributes
{
    UINavigationController *navigationController = self.navigationController;
    
    if (self.title && !navigationController.navigationBarHidden) {
        
        UIViewController<CGNavigationAppearanceProtocol> * viewController = (id)self;
        NSDictionary *titleTextAttributes = nil;
        
        if ([viewController respondsToSelector:@selector(cg_prefersNavigationBarTitleTextAttributes)]) {
            //获取自定义的标题属性
            titleTextAttributes = [viewController cg_prefersNavigationBarTitleTextAttributes];
        }else if ([navigationController isKindOfClass:[CGNavigationController class]]) {
            
            //获取默认的导航栏颜色
            titleTextAttributes = [(CGNavigationController *)navigationController defaultTitleTextAttributes];
        }
        
        if (titleTextAttributes && ![titleTextAttributes isEqualToDictionary:navigationController.navigationBar.titleTextAttributes]) {
            navigationController.navigationBar.titleTextAttributes  = titleTextAttributes;
        }
    }
}

- (void)cg_setupNavigationBarHiddenWithAnimation:(BOOL)animated
{
    
    UIViewController<CGNavigationAppearanceProtocol> * viewController = (id)self;
    UINavigationController *navigationController = self.navigationController;
    
    //设置导航栏显隐
    BOOL isShouldHidden = self.cg_prefersNavigationBarHidden;
    //    if ([navigationController isKindOfClass:[CGNavigationController class]]) {
    //        isShouldHidden  = [(CGNavigationController *)navigationController defaultNavigationBarHidden];
    //    }
    
    if ([viewController respondsToSelector:@selector(cg_prefersNavigationBarHidden)]) {
        isShouldHidden  = [viewController cg_prefersNavigationBarHidden];
    }
    
    if (navigationController.navigationBarHidden != isShouldHidden) {
        [navigationController setNavigationBarHidden:isShouldHidden animated:animated];
    }
}

- (BOOL)cg_shouldSetupCurrentViewController
{
    if (![self.navigationController isKindOfClass:[CGNavigationController class]] && ![self conformsToProtocol:@protocol(CGNavigationAppearanceProtocol)]) {
        //当视图没有实现CGNavigationAppearanceProtocol，或导航栏不是CGNavigationController时取消对导航栏的设置
        return NO;
    }
    return YES;
}
@end

@implementation UIViewController (CGFullscreenPopGesture)

+ (void)load
{
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector    = @selector(viewWillAppear:);
        SEL swizzledSelector    = @selector(cg_viewWillAppear:);
        
        [self cg_exchangeInstanceMethodWithOriginalselector:originalSelector swizzledSelector:swizzledSelector];
    });
}

- (void)cg_viewWillAppear:(BOOL)animation
{
    [self cg_viewWillAppear:animation];
    
    if ([self cg_shouldSetupCurrentViewController]) {
        
        [self cg_setupNavigationBarHiddenWithAnimation:animation];
        [self cg_setupNavigationBarAppearance];
    }
}

- (void)setCg_interactivePopDisabled:(BOOL)interactivePopDisabled
{
    objc_setAssociatedObject(self, @selector(cg_interactivePopDisabled), @(interactivePopDisabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cg_interactivePopDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCg_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance
{
    objc_setAssociatedObject(self, @selector(cg_interactivePopMaxAllowedInitialDistanceToLeftEdge), @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cg_interactivePopMaxAllowedInitialDistanceToLeftEdge
{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setCg_prefersNavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(cg_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)cg_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
