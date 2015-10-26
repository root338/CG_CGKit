//
//  CGNavigationAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGNavigationAppearance.h"

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
    
    UIOffset offset = self.hideBackItemTitle ? UIOffsetMake(9999, 9999) : UIOffsetZero;
    [self.appearanceForBackItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}
@end
