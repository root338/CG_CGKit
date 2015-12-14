//
//  CGLineBoxLayerView.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGLineBoxLayerView.h"

@implementation CGLineBoxLayerView

- (UIEdgeInsets)alignmentRectInsets
{
    return UIEdgeInsetsMake(-15, -15, -15, -15);
}

- (CGRect)frameForAlignmentRect:(CGRect)alignmentRect
{
    return CGRectMake(0, 0, 100, 100);
}

@end
