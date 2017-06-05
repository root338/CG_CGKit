//
//  CGBaseLayoutView.m
//  QuickAskCommunity
//
//  Created by DY on 2017/6/5.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "CGBaseLayoutView.h"

@implementation CGBaseLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints  = NO;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
