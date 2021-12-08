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

- (void)applyAppearance {
    if (@available(iOS 13.0, *)) {
        
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = self.barTintColor;
        appearance.backgroundImage = self.backgroundImageForNavigationBar;
        appearance.shadowImage = self.shadowImageForNavigationBar;
        appearance.titleTextAttributes = self.titleTextAttributes;
        [appearance setBackIndicatorImage:self.backItemImage transitionMaskImage:self.backItemImage];
        appearance.titlePositionAdjustment = UIOffsetMake(0, self.titleVerticalPositionAdjustment);
        if (self.hideBackItemTitle) {
            appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffsetMake(-1000, 0);
        }
        [self.appearanceForNavigationBar setStandardAppearance:appearance];
        [self.appearanceForNavigationBar setScrollEdgeAppearance:appearance];
    }else {
        [self.appearanceForNavigationBar setBackgroundImage:self.backgroundImageForNavigationBar forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.appearanceForNavigationBar setBarTintColor:self.barTintColor];
        [self.appearanceForNavigationBar setShadowImage:self.shadowImageForNavigationBar];
        [self.appearanceForNavigationBar setTitleTextAttributes:self.titleTextAttributes];
        [self.appearanceForNavigationBar setBackIndicatorImage:self.backItemImage];
        [self.appearanceForNavigationBar setBackIndicatorTransitionMaskImage:self.backItemImage];
        [self.appearanceForNavigationBar setTitleVerticalPositionAdjustment:self.titleVerticalPositionAdjustment forBarMetrics:UIBarMetricsDefault];
        UIOffset offset = self.hideBackItemTitle ? UIOffsetMake(-1000, 0) : UIOffsetZero;
        [self.appearanceForBackItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
    }
}
@end
