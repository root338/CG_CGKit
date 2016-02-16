//
//  CGNavigationAppearanceProtocol.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 设置导航栏外观的协议 */
@protocol CGNavigationAppearanceProtocol <NSObject>

@optional
/** 是否隐藏导航栏 */
- (BOOL)cg_prefersNavigationBarHidden;

/** 导航栏的背景色 */
- (UIColor *)cg_prefersNavigationBarBackgroundColor;

/** 导航栏的背景图 */
//- (UIImage *)cg_prefersNavigationBarBackgroundImage;
@end

NS_ASSUME_NONNULL_END