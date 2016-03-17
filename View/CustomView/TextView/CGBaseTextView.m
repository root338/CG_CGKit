//
//  CGBaseTextView.m
//  TestProject
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGBaseTextView.h"


@implementation CGBaseTextView

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    
}

@end
