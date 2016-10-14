//
//  CGInputAccessoryViewAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGInputAccessoryViewAppearance.h"

@implementation CGInputAccessoryViewAppearance

+ (instancetype)defalutAppearance
{
    return [CGInputAccessoryViewAppearance new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _arrowSize              = CGSizeMake(25, 25);
        _arrowLineWidth         = 1.5;
        _arrowImageTintColor    = [UIColor blueColor];
        
        _backgroundColor        = [UIColor whiteColor];
        _finishTitle            = @"完成";
    }
    return self;
}

@end
