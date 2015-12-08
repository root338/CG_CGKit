//
//  UITableView+CGScrolling.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/8.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UITableView+CGScrolling.h"

#import "UIView+CGSetupFrame.h"

@implementation UITableView (CGScrolling)

- (void)cg_tableViewScrollingToBottom
{
    [self cg_tableViewScrollingToBottomIsAnimated:NO];
}

- (void)cg_tableViewScrollingToBottomIsAnimated:(BOOL)isAnimated
{
    CGFloat offsetY = self.contentSize.height - self.height;
    if (offsetY > 0) {
        CGPoint contentOffset = CGPointMake(self.contentOffset.x, offsetY);
        [self setContentOffset:contentOffset animated:isAnimated];
    }
}

@end
