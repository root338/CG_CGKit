//
//  UIView+CGOrientation.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGOrientation.h"
#import "UIApplication+CGVerifyDeviceDirection.h"

@implementation UIView (CGOrientation)

- (CGDeivceDirection)currentOrientation
{
    return [UIApplication cg_currentDeviceDirection];
}

@end
