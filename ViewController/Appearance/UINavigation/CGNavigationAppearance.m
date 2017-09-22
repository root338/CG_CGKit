//
//  CGNavigationAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGNavigationAppearance.h"
//#import "CGVerifyIOSVersionHeader.h"

@implementation CGNavigationAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.appearanceForNavigationBar = [UINavigationBar appearance];
        self.appearanceForBackItem = [UIBarButtonItem appearance];
    }
    return self;
}

- (void)applyAppearance
{
    if (self.barTintColor) {
        [self.appearanceForNavigationBar setBarTintColor:self.barTintColor];
    }
    
    if (self.backgroundImageForNavigationBar) {
        [self.appearanceForNavigationBar setBackgroundImage:self.backgroundImageForNavigationBar forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    
    if (self.shadowImageForNavigationBar) {
        [self.appearanceForNavigationBar setShadowImage:self.shadowImageForNavigationBar];
    }
    
    if (self.titleTextAttributes) {
        [self.appearanceForNavigationBar setTitleTextAttributes:self.titleTextAttributes];
    }
    
    if (self.backItemImage) {
        [self.appearanceForNavigationBar setBackIndicatorImage:self.backItemImage];
        [self.appearanceForNavigationBar setBackIndicatorTransitionMaskImage:self.backItemImage];
    }
    
    if (self.titleVerticalPositionAdjustment) {
        [self.appearanceForNavigationBar setTitleVerticalPositionAdjustment:self.titleVerticalPositionAdjustment forBarMetrics:UIBarMetricsDefault];
    }
    
    // iOS 11 下会出现问题，导航栏会根据设置的偏移量来设置视图布局，所以这样设置会导致按钮图片，标题，右边按钮都无法看到
    // 所以现在隐藏导航栏视图，可以在加载的视图控制器页设置 navigationItem.backBarButtonItem 来手动设置返回标题为空
//    UIOffset offset = self.hideBackItemTitle ? UIOffsetMake(9999, 9999) : UIOffsetZero;
//    [self.appearanceForBackItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}
@end
