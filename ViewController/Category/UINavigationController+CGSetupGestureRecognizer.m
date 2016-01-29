//
//  UINavigationController+CGSetupGestureRecognizer.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UINavigationController+CGSetupGestureRecognizer.h"

#import "UIViewController+CGFullscreenPopGesture.h"

#import <objc/runtime.h>

@interface _CGFullScreenPopGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation _CGFullScreenPopGestureRecognizerDelegate

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    UIViewController *topViewController = [self.navigationController.viewControllers lastObject];
    /** 视图控制器是否关闭了横滑功能 */
    if (topViewController.cg_interactivePopDisabled) {
        return NO;
    }
    
    /** 视图控制器是否设置了有效的左边距距离 */
    if (topViewController.cg_interactivePopMaxAllowedInitialDistanceToLeftEdge > 0) {
        CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
        if (beginningLocation.x > topViewController.cg_interactivePopMaxAllowedInitialDistanceToLeftEdge) {
            return NO;
        }
    }
    
    /** 导航栏是否正在动画 */
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return YES;
}

@end

@implementation UINavigationController (CGSetupGestureRecognizer)

#pragma mark - 全屏横滑回退

/** 打开全屏回退手势 */
- (void)cg_openFullScreenPopGestureRecognizer
{
    if (![self.fullScreenPopGestureRecognizer.view.gestureRecognizers containsObject:self.fullScreenPopGestureRecognizer]) {
        
        self.fullScreenPopGestureRecognizer.delegate = self.cg_fullScreenPopGestureRecognizerDelegate;
        [self.navigationController.view addGestureRecognizer:self.fullScreenPopGestureRecognizer];
        
        //使用默认的滑动样式
        NSArray *targets        = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id target               = [targets.firstObject objectForKey:@"target"];
        NSString *selectName    = [targets.firstObject objectForKey:@"action"];
        [self.fullScreenPopGestureRecognizer addTarget:target action:NSSelectorFromString(selectName)];
        
        self.interactivePopGestureRecognizer.enabled    = NO;
    }
}

#pragma mark - 设置属性

- (UIPanGestureRecognizer *)fullScreenPopGestureRecognizer
{
    UIPanGestureRecognizer *_fullScreenPopGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (_fullScreenPopGestureRecognizer) {
        
        _fullScreenPopGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        _fullScreenPopGestureRecognizer.maximumNumberOfTouches  = 1;
        
        objc_setAssociatedObject(self, @selector(fullScreenPopGestureRecognizer), _fullScreenPopGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _fullScreenPopGestureRecognizer;
}

- (_CGFullScreenPopGestureRecognizerDelegate *)cg_fullScreenPopGestureRecognizerDelegate
{
    _CGFullScreenPopGestureRecognizerDelegate *_fullScreenPopGestureRecognizerDelegate = objc_getAssociatedObject(self, _cmd);
    if (!_fullScreenPopGestureRecognizerDelegate) {
        
        _fullScreenPopGestureRecognizerDelegate = [[_CGFullScreenPopGestureRecognizerDelegate alloc] init];
        _fullScreenPopGestureRecognizerDelegate.navigationController = self;
        objc_setAssociatedObject(self, @selector(cg_fullScreenPopGestureRecognizerDelegate), _fullScreenPopGestureRecognizerDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _fullScreenPopGestureRecognizerDelegate;
}
@end
