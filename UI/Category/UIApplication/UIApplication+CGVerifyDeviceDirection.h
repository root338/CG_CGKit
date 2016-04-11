//
//  UIApplication+CGVerifyDeviceDirection.h
//  TestCG_CGKit
//
//  Created by DY on 16/4/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 设备方向——简易版 */
typedef NS_ENUM(NSInteger, CGDeivceDirection) {
    
    /** 未知 */
    CGDeivceDirectionUnknown,
    /** 竖屏 */
    CGDeivceDirectionPortrait,
    /** 横屏 */
    CGDeivceDirectionLandscape,
};

/** 验证设备方向 */
@interface UIApplication (CGVerifyDeviceDirection)

+ (CGDeivceDirection)cg_currentDeviceDirection;

@end
