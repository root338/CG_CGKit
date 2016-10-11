//
//  CGIconConfig.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGIconConfig.h"

@implementation CGIconConfig

- (instancetype)init
{
    self    = [super init];
    if (self) {
//        _backgroundColor    = nil;
        _size               = CGSizeMake(32.0, 32.0);
        _opaque             = NO;
        _scale              = [UIScreen mainScreen].scale;
        _tintColor          = [UIColor blackColor];
        _lineWidth          = 2.0;
        _lineJoinStyle      = kCGLineJoinMiter;
        _miterLimit         = 0;
        _canvasRotateAngle  = 0;
        _disableAdjustToSize    = NO;
        
        _marginEdgeInset        = UIEdgeInsetsZero;
    }
    return self;
}

@end
