//
//  CGRefreshIconConfig.m
//  TestCG_CGKit
//
//  Created by DY on 2016/10/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRefreshIconConfig.h"

@implementation CGRefreshIconConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _startAngle = 0;
        _endAngle   = 270;
        _arrowWidth = self.lineWidth * 3;
    }
    return self;
}

@end
