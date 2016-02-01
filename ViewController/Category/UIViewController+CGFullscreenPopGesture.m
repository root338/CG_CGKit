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
 *  @warning 普通视图控制器不应该调用
 */
@interface UIViewController (CGSetupNavigationBar)

/** 设置视图控制器的导航栏颜色 */
- (void)cg_setupNavigationBarBackgroundColor;

/** 设置视图控制器的导航栏是否隐藏 */
- (void)cg_setupNavigationBarHiddenWithAnimation:(BOOL)animated;
@end

@implementation UIViewController (CGSetupNavigationBar)

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
        }else {
            
            navigationBarBackground  = navigationController.navigationBar.barTintColor;
        }
        
        if (![navigationBarBackground isEqual:navigationController.navigationBar.barTintColor]) {
            
            navigationController.navigationBar.barTintColor  = navigationBarBackground;
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
    
    [self cg_setupNavigationBarHiddenWithAnimation:animation];
    [self cg_setupNavigationBarBackgroundColor];
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
