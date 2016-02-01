//
//  CGNavigationBarViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

@class CGNavigationBarView;
NS_ASSUME_NONNULL_BEGIN
/** 自定义导航栏的视图控制器 */
@interface CGNavigationBarViewController : CGBaseViewController

@property (nullable, nonatomic, strong, readonly) UINavigationBar *navigationBar;
@property (nonatomic, strong, readonly) UIView *contentView;

/** 视图控制器视图 */
@property (nonatomic, strong, readonly) CGNavigationBarView *navigationBarView;


@end
NS_ASSUME_NONNULL_END