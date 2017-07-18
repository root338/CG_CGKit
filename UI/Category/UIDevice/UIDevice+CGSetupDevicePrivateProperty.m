//
//  UIDevice+CGSetupDevicePrivateProperty.m
//  QuickAskCommunity
//
//  Created by DY on 2017/7/18.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "UIDevice+CGSetupDevicePrivateProperty.h"

@implementation UIDevice (CGSetupDevicePrivateProperty)

- (BOOL)setupScreenOrientation:(UIInterfaceOrientation)orientation
{
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
    return YES;
}

@end
