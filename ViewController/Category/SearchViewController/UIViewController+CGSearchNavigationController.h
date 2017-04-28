//
//  UIViewController+CGSearchNavigationController.h
//  QuickAskCommunity
//
//  Created by DY on 2017/4/28.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGSearchNavigationController)

/** 搜索最近的UINavigationController及其子类 */
- (nullable __kindof UINavigationController *)searchNavigationController;
/** 搜索最近的指定导航栏类及其子类 */
- (nullable __kindof UINavigationController *)searchNavigationControllerWithTargetClass:(Class)targetNavigationControllerClassName;

/** 搜索指定导航栏 类 */
- (nullable __kindof UINavigationController *)searchNavigationControllerWithMemberTargetClass:(Class)targetNavigationControllerClassName;

@end

NS_ASSUME_NONNULL_END
