//
//  CGSingleTitleBaseView.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGSingleTitleBaseView.h"
#import "UIView+CG_CGAreaCalculate.h"

@implementation CGSingleTitleBaseView

- (void)initialization
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.singleTitleView) {
        self.singleTitleView.frame = CGRectWithMargin(self.bounds, self.marginEdgeInsets);
    }
}

@end
