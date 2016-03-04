//
//  CGCycleScrollView+CGScrollAnimation.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/1.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

@interface CGCycleScrollView (CGScrollAnimation)

- (void)cg_scrollWithScrollView:(UIScrollView *)scrollView previousView:(UIView *)previousView currentView:(UIView *)currentView nextView:(UIView *)nextView animationStyle:(CGCycleViewScrollAnimationStyle)style;

@end
