//
//  CGIconConfig.m
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGIconConfig.h"

#import "UIView+CG_CGAreaCalculate.h"

@implementation CGIconConfig

- (instancetype)init
{
    self    = [super init];
    if (self) {
        
//        _backgroundColor    = nil;
        _size               = CGSizeMake(25.0, 25.0);
        _opaque             = NO;
        _scale              = [UIScreen mainScreen].scale;
        _tintColor          = [UIColor blackColor];
        _lineWidth          = 2.0;
        _lineJoinStyle      = kCGLineJoinMiter;
        _miterLimit         = 0;
//        _canvasRotateAngle  = 0;
        
        _marginEdgeInset        = UIEdgeInsetsZero;
    }
    return self;
}

- (CGSize)canvasAvailableSize
{
    return CG_CGSizeWidthMaxSize(self.size, self.marginEdgeInset);
}

- (CGPoint)drawStartPoint
{
    return CGPointMake(self.marginEdgeInset.left, self.marginEdgeInset.top);
}

@end
