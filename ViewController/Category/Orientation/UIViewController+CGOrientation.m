//
//  UIViewController+CGOrientation.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIViewController+CGOrientation.h"

#import "UIApplication+CGVerifyDeviceDirection.h"


@implementation UIViewController (CGOrientation)

- (CGDeivceDirection)currentOrientation
{
    return [UIApplication cg_currentDeviceDirection];
}

@end
