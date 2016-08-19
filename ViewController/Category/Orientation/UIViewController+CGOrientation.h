//
//  UIViewController+CGOrientation.h
//  TestCG_CGKit
//
//  Created by DY on 16/8/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGDeviceOrientationHeader.h"

@interface UIViewController (CGOrientation)

@property (nonatomic, assign, readonly) CGDeivceDirection currentOrientation;

@end
