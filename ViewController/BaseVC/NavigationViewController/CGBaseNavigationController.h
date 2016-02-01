//
//  CGBaseNavigationViewController.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGNavigationDelegateObject.h"

@interface CGBaseNavigationController : UINavigationController

/** 实现导航栏代理对象 */
@property (strong, nonatomic, readonly) CGNavigationDelegateObject *navigationDelegateObject;

/** 是否隐藏NavigationBar */
@property (assign, nonatomic) BOOL preferredNavigationBarHidden;

/** 显隐NavigationBar时是否执行动画 */
@property (assign, nonatomic) BOOL preferredNavigationBarAnimation;

/** 是否应该隐藏NavigationBar */
- (void)shouldHideNavigationBarWithViewController:(id)viewController animation:(BOOL)animation;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveTransition;
@end
