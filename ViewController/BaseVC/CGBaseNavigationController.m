//
//  CGBaseNavigationViewController.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseNavigationController.h"
#import "CGBaseNavigationControllerDelegate.h"

@interface CGBaseNavigationController ()
<
    UIGestureRecognizerDelegate
>

/** 实现导航栏代理对象 */
@property (strong, nonatomic, readwrite) CGNavigationDelegateObject *navigationDelegateObject;

@end

@implementation CGBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self.navigationDelegateObject;
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleControllerPopGesture:)];
    pan.delegate = self;
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shouldHideNavigationBarWithViewController:(id)viewController animation:(BOOL)animation
{
    BOOL isShouldAnimated = self.preferredNavigationBarAnimation;
    BOOL isShouldHide = self.preferredNavigationBarHidden;
    if ([viewController respondsToSelector:@selector(hideNavigationBarWithNavigationController:)]) {
        isShouldHide = [(UIViewController<CGBaseNavigationControllerDelegate> *)viewController hideNavigationBarWithNavigationController:self];
    }
    
    if (isShouldHide != self.navigationBarHidden) {
        [self setNavigationBarHidden:isShouldHide animated:isShouldAnimated];
    }
    
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    if ([self.transitionCoordinator isAnimated]) {
//        return NO;
//    }
//    
//    if ([gestureRecognizer.view respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
//        BOOL result = [gestureRecognizer.view gestureRecognizerShouldBegin:gestureRecognizer];
//        return result;
//    }
//    return YES;
    return self.viewControllers.count != 1;
}

#pragma mark - 滑动事件触发方法
- (void)handleControllerPopGesture:(UIPanGestureRecognizer *)recognizer
{
    
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        [self.interactiveTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateCancelled || recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (progress >= 0.5) {
            
            [self.interactiveTransition finishInteractiveTransition];
        }else {
            
            [self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 设置属性
- (CGNavigationDelegateObject *)navigationDelegateObject
{
    if (_navigationDelegateObject) {
        return _navigationDelegateObject;
    }
    
    _navigationDelegateObject = [[CGNavigationDelegateObject alloc] init];
    return _navigationDelegateObject;
}
@end
