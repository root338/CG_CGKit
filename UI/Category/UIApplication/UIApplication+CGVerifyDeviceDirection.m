//
//  UIApplication+CGVerifyDeviceDirection.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIApplication+CGVerifyDeviceDirection.h"

@implementation UIApplication (CGVerifyDeviceDirection)

+ (CGDeivceDirection)cg_currentDeviceDirection
{
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    CGDeivceDirection deviceDirecton            = CGDeivceDirectionUnknown;
    if (statusBarOrientation == UIInterfaceOrientationPortrait || statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        deviceDirecton  = CGDeivceDirectionPortrait;
    }else if (statusBarOrientation == UIInterfaceOrientationLandscapeLeft || statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        deviceDirecton  = CGDeivceDirectionLandscape;
    }
    return deviceDirecton;
}

@end
