//
//  CGCloseIconConfig.m
//  TestCG_CGKit
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCloseIconConfig.h"

@implementation CGCloseIconConfig

+ (instancetype)defalutCloseConfig
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _angle  = 0;
    }
    return self;
}

@end
