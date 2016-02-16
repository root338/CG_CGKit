//
//  CGNavigationBarViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"

#import "CGNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN
/** 自定义导航栏的视图控制器 */
@interface CGNavigationBarViewController : CGBaseViewController<CGNavigationBarViewDelegate>

/** 自定义状态栏的颜色，默认为NO(和导航栏的背景色相同) */
@property (nonatomic, assign) BOOL customStatusViewBackgroundColor;

@property (nullable, nonatomic, strong, readonly) UINavigationBar *navigationBar;
@property (nullable, nonatomic, strong, readonly) UIView *contentView;

/** 视图控制器视图 */
@property (nullable, nonatomic, strong, readonly) CGNavigationBarView *navigationBarView;

/** 
 *  设置视图控制器的view 
 *  @param 子类可以重写该方法重新设置视图控制器的view
 */
- (void)setupView;
@end
NS_ASSUME_NONNULL_END