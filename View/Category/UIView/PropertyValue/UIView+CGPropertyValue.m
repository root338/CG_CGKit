//
//  UIView+CGPropertyValue.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGPropertyValue.h"
#import "UIApplication+CGVerifyDeviceDirection.h"

@implementation UIView (CGPropertyValue)

#pragma mark - 设置属性
- (BOOL)isStatusBarHidden
{
    return [[UIApplication sharedApplication] isStatusBarHidden];
}

- (CGDeivceDirection)currentOrientation
{
    return [UIApplication cg_currentDeviceDirection];
}

@end
