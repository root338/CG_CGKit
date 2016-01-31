//
//  CGNavigationController.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGNavigationAppearanceProtocol;
NS_ASSUME_NONNULL_BEGIN
@interface CGNavigationController : UINavigationController

@property (nullable, nonatomic, weak) id<CGNavigationAppearanceProtocol> appearanceDelegate;

/** 导航栏默认的颜色 */
@property (nullable, nonatomic, strong) UIColor *defaultNavigationBarBackgroundColor;

@end
NS_ASSUME_NONNULL_END