//
//  CGNavigationController.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationController.h"

#import "CGNavigationDelegateObject.h"

#import "UINavigationController+CGSetupGestureRecognizer.h"

#import "CGPrintLogHeader.h"

@interface CGNavigationController ()
{
    
}
@property (nonatomic, strong) CGNavigationDelegateObject *delegateObject;
@end

@implementation CGNavigationController

@synthesize enablePopGestureRecognizer = _enablePopGestureRecognizer;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializationPropertyValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializationPropertyValue];
    }
    return self;
}

- (void)initializationPropertyValue
{
    _enablePopGestureRecognizer             = YES;
    _interactivePopGestureRecognizerType    = CGInteractivePopGestureRecognizerTypeFullScreen;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPopGestureRecognizer];
    
    self.delegateObject = [[CGNavigationDelegateObject alloc] init];
    self.delegate       = self.delegateObject;
    
    [self performSelector:@selector(setupDefaultAppearance) withObject:nil afterDelay:0];
}

- (void)setupDefaultAppearance
{
    if (!self.defaultTitleTextAttributes) {
        self.defaultTitleTextAttributes             = self.navigationBar.titleTextAttributes;
    }
    
    if (!self.defaultNavigationBarBackgroundColor) {
        self.defaultNavigationBarBackgroundColor    = self.navigationBar.barTintColor;
    }
}

#pragma mark - 设置导航栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIStatusBarStyle statusBarStyle = self.defaultStatusBarStyle;
    if ([self.topViewController respondsToSelector:@selector(preferredStatusBarStyle)]) {
        statusBarStyle  = [self.topViewController preferredStatusBarStyle];
    }
    return statusBarStyle;
}

//- (BOOL)prefersStatusBarHidden
//{
//    BOOL statusBarHidden    = self.defaultStatusBarHidden;
//    if ([self.topViewController respondsToSelector:@selector(prefersStatusBarHidden)]) {
//        statusBarHidden = [self.topViewController prefersStatusBarHidden];
//    }
//    return statusBarHidden;
//}
//
//- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
//{
//    UIStatusBarAnimation statusBarUpdateAnimation   = self.defaultStatusBarAnimation;
//    if ([self.topViewController respondsToSelector:@selector(preferredStatusBarUpdateAnimation)]) {
//        statusBarUpdateAnimation    = [self.topViewController preferredStatusBarUpdateAnimation];
//    }
//    return statusBarUpdateAnimation;
//}

- (void)setupPopGestureRecognizer
{
    if ([self respondsToSelector:@selector(openFullScreenPopGestureRecognizer)] == NO || [self respondsToSelector:@selector(fullScreenPopGestureRecognizer)] == NO) {
        
        CGErrorLog(@"没有导入UINavigationController+CGSetupGestureRecognizer.h扩展，会导致CGNavigationController 及其子类功能不完整");
        return;
    }
    BOOL fullScreenPopGestureRecognizerEnable   = NO;
    BOOL systemPopGestureRecognizerEnable       = NO;
    if (self.enablePopGestureRecognizer) {
        
        switch (self.interactivePopGestureRecognizerType) {
            case CGInteractivePopGestureRecognizerTypeSystem:
                systemPopGestureRecognizerEnable        = YES;
                break;
            case CGInteractivePopGestureRecognizerTypeFullScreen:
                fullScreenPopGestureRecognizerEnable    = YES;
                break;
            default:
                break;
        }
    }
    
    if (self.interactivePopGestureRecognizer.enabled != systemPopGestureRecognizerEnable) {
        self.interactivePopGestureRecognizer.enabled    = systemPopGestureRecognizerEnable;
    }
    
    if (fullScreenPopGestureRecognizerEnable) {
        
        [self openFullScreenPopGestureRecognizer];
        
    }else {
        
        self.fullScreenPopGestureRecognizer.enabled = fullScreenPopGestureRecognizerEnable;
    }
    
}

#pragma mark - 设置属性
//- (void)setEnableViewControllerManager:(BOOL)enableViewControllerManager
//{
//    if (_enableViewControllerManager != enableViewControllerManager) {
//        
//        
//    }
//}

- (void)setEnablePopGestureRecognizer:(BOOL)enablePopGestureRecognizer
{
    if (_enablePopGestureRecognizer != enablePopGestureRecognizer) {
        _enablePopGestureRecognizer    = enablePopGestureRecognizer;
        [self setupPopGestureRecognizer];
    }
}

- (BOOL)disablePopGestureRecognizer
{
    BOOL isEnablePopGestureRecognizer  = NO;
    switch (self.interactivePopGestureRecognizerType) {
        case CGInteractivePopGestureRecognizerTypeSystem:
            isEnablePopGestureRecognizer    = self.interactivePopGestureRecognizer.enabled;
            break;
        case CGInteractivePopGestureRecognizerTypeFullScreen:
            isEnablePopGestureRecognizer    = self.fullScreenPopGestureRecognizer.enabled;
            break;
        default:
            break;
    }
    return isEnablePopGestureRecognizer;
}

- (void)setInteractivePopGestureRecognizerType:(CGInteractivePopGestureRecognizerType)interactivePopGestureRecognizerType
{
    if (_interactivePopGestureRecognizerType != interactivePopGestureRecognizerType) {
        _interactivePopGestureRecognizerType    = interactivePopGestureRecognizerType;
        [self setupPopGestureRecognizer];
    }
}

@end
