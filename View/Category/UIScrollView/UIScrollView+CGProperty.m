//
//  UIScrollView+CGProperty.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/14.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIScrollView+CGProperty.h"
#import "UIView+CGSetupFrame.h"

@implementation UIScrollView (CGProperty)

- (CGRect)scrollVisibleRect
{
    return (CGRect){self.contentOffset, self.bounds.size};
}

- (NSInteger)cg_calculateScrollPageWithScale:(CGFloat)scale
{
    
    CGFloat pageNumber      = (self.contentOffset.x / self.width) + 1;
    NSInteger pageInteget   = (NSInteger)pageNumber;
    NSInteger targetPage    = pageInteget;
    
    if (pageNumber > pageInteget) {
        if (pageNumber - pageInteget > scale) {
            targetPage  = pageInteget + 1;
        }
    }
    
    return targetPage;
}

@end
