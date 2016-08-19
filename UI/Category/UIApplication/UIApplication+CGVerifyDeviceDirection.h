//
//  UIApplication+CGVerifyDeviceDirection.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGDeviceOrientationHeader.h"

/** 验证设备方向 */
@interface UIApplication (CGVerifyDeviceDirection)

+ (CGDeivceDirection)cg_currentDeviceDirection;

@end
