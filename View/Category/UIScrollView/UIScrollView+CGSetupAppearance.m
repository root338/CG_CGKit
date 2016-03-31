//
//  UIScrollView+CGInit.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIScrollView+CGSetupAppearance.h"

@implementation UIScrollView (CGSetupAppearance)

@dynamic showsScrollIndicator;

- (void)cg_setupWithFrame:(CGRect)frame showScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled
{
    
    self.frame                  = frame;
    self.showsScrollIndicator   = showScrollIndicator;
    
    if (self.pagingEnabled != paramPagingEnabled) {
        self.pagingEnabled          = paramPagingEnabled;
    }
}

- (void)setShowsScrollIndicator:(BOOL)showsScrollIndicator
{
    
    if (self.showsHorizontalScrollIndicator != showsScrollIndicator) {
        self.showsHorizontalScrollIndicator = showsScrollIndicator;
    }
    
    if (self.showsVerticalScrollIndicator != showsScrollIndicator) {
        self.showsVerticalScrollIndicator = showsScrollIndicator;
    }
}
@end
