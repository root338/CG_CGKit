//
//  CGCycleScrollView+CGScrollAnimation.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/1.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGCycleScrollView.h"

NS_ASSUME_NONNULL_BEGIN
@interface CGCycleScrollView (CGScrollAnimation)

- (void)cg_scrollWithScrollView:(UIScrollView *)scrollView animationStyle:(CGCycleViewScrollAnimationStyle)style;

@end
NS_ASSUME_NONNULL_END