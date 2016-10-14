//
//  UINavigationController+CGSetupGestureRecognizer.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UINavigationController+CGSetupGestureRecognizer.h"

#import "UIViewController+CGFullscreenPopGesture.h"

#import "CGNavigationViewControllerManager.h"
#import <objc/runtime.h>

@interface _CGGestureRecognizerManagerForNavigationView : NSObject

//发送的目标
@property (weak, nonatomic) id target;
//下拉刷新发送的消息
@property (assign, nonatomic) SEL selector;

@end

@implementation _CGGestureRecognizerManagerForNavigationView

@end

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
- (BOOL)openFullScreenPopGestureRecognizer
{
    return [self handleFullScreenPopGestureRecognizerWithIsOpen:YES];
}

- (BOOL)closeFullScreenPopGestureRecognizer
{
    return [self handleFullScreenPopGestureRecognizerWithIsOpen:NO];
}

- (BOOL)handleFullScreenPopGestureRecognizerWithIsOpen:(BOOL)isOpen
{
    BOOL isResult   = YES;
    if (isOpen) {
        
        if (self.interactivePopGestureRecognizer.view.gestureRecognizers == nil) {
            
            isResult    = NO;
        }else if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fullScreenPopGestureRecognizer]) {
            
            //使用默认的滑动样式
            NSArray *targets        = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
            id target               = [targets.firstObject valueForKey:@"target"];
            SEL select              = NSSelectorFromString(@"handleNavigationTransition:");
            
            if (target && [target respondsToSelector:select]) {
                
                [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullScreenPopGestureRecognizer];
                
                self.fullScreenPopGestureRecognizer.delegate = self.cg_fullScreenPopGestureRecognizerDelegate;
                
                [self.fullScreenPopGestureRecognizer addTarget:target action:select];
                
                self.interactivePopGestureRecognizer.enabled    = NO;
            }
        }
    }else {
        
        if (self.fullScreenPopGestureRecognizer) {
            
            [self.fullScreenPopGestureRecognizer.view removeGestureRecognizer:self.fullScreenPopGestureRecognizer];
        }
        
        if (self.interactivePopGestureRecognizer.enabled != YES) {
            self.interactivePopGestureRecognizer.enabled    = YES;
        }
    }
    return isResult;
}

- (void)handlePopGestureRecognizer:(UIPanGestureRecognizer *)recognizer
{
    
    CGFloat progress    = [recognizer locationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress    = MAX(0, MIN(1, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.interactivePopTransition   = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        if (progress > 0.5) {
            
            [self.interactivePopTransition finishInteractiveTransition];
        }else {
            
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

#pragma mark - 设置属性

- (UIPanGestureRecognizer *)fullScreenPopGestureRecognizer
{
    UIPanGestureRecognizer *_fullScreenPopGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (!_fullScreenPopGestureRecognizer) {
        
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

- (_CGGestureRecognizerManagerForNavigationView *)gestureRecognizerManager
{
    _CGGestureRecognizerManagerForNavigationView *_gestureRecognizerManager = objc_getAssociatedObject(self, _cmd);
    if (_gestureRecognizerManager == nil) {
        _gestureRecognizerManager   = [[_CGGestureRecognizerManagerForNavigationView alloc] init];
        objc_setAssociatedObject(self, @selector(gestureRecognizerManager), _gestureRecognizerManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _gestureRecognizerManager;
}
@end

@implementation UINavigationController (CGPopAnimation)

- (void)setInteractivePopTransition:(UIPercentDrivenInteractiveTransition *)interactive
{
    objc_setAssociatedObject(self, @selector(interactivePopTransition), interactive, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPercentDrivenInteractiveTransition *)interactivePopTransition
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
