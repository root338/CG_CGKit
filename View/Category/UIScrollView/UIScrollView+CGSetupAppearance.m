//
//  UIScrollView+CGInit.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIScrollView+CGSetupAppearance.h"

@implementation UIScrollView (CGSetupAppearance)

- (void)cg_setupWithShowScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled
{
    [self cg_setupWithFrame:CGRectZero showScrollIndicator:showScrollIndicator pagingEnabled:paramPagingEnabled];
}

- (void)cg_setupWithFrame:(CGRect)frame showScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled
{
    
    self.frame = frame;
    self.showsHorizontalScrollIndicator = showScrollIndicator;
    self.showsVerticalScrollIndicator = showScrollIndicator;
    self.pagingEnabled = paramPagingEnabled;
}

@end
