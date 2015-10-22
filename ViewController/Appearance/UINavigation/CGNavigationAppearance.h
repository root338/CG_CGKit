//
//  CGNavigationAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  设置导航栏的外观
 */
@interface CGNavigationAppearance : NSObject

#pragma mark - 设置的目标对象
/** 导航栏外观设置对象，默认为UINavigationBar */
@property (strong, nonatomic) id appearanceForNavigationBar;

/** 导航栏回退按钮外观设置对象，默认为UIBarButtonItem */
@property (strong, nonatomic) id appearanceForBackItem;

#pragma mark - UINavigationBar或其子类属性设置

/** 标题颜色 */
@property (strong, nonatomic) UIColor *barTintColor;

/** 竖屏下的背景图片 像素128PX高*/
@property (strong, nonatomic) UIImage *backgroundImageForNavigationBar;

/** 导航栏背景 */
@property (strong, nonatomic) UIImage *shadowImageForNavigationBar;

/** 标题样式 */
@property (strong, nonatomic) NSDictionary<NSString *, id> *titleTextAttributes;

/** 导航栏标题的垂直偏移量 */
@property (assign, nonatomic) CGFloat titleVerticalPositionAdjustment;


#pragma mark - 回退按钮样式设置
/** 导航栏回退按钮图片 */
@property (strong, nonatomic) UIImage *backItemImage;

/** 隐藏回退按钮的标题，竖屏下的设置 */
@property (assign, nonatomic) BOOL hideBackItemTitle;

#pragma mark - 方法
/** 应用设置 */
- (void)applyAppearance;
@end
