//
//  UIDevice+CGSetupDevicePrivateProperty.h
//  QuickAskCommunity
//
//  Created by DY on 2017/7/18.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CGSetupDevicePrivateProperty)
/// 设置屏幕当前的的方向
- (BOOL)setupScreenOrientation:(UIInterfaceOrientation)orientation;

@end
