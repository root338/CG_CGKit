//
//  CGNavigationBarViewController.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGNavigationBarViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class CGNavigationBarView;

/** 自定义导航栏的视图控制器 */
@interface CGNavigationBarViewController : CGBaseViewController<CGNavigationBarViewDelegate>

/** 自定义导航栏 */
@property (nullable, nonatomic, strong, readonly) UINavigationBar *navigationBar;
/** 内容视图 */
@property (nullable, nonatomic, strong, readonly) UIView *contentView;

/** 视图控制器视图 */
@property (nullable, nonatomic, strong, readonly) CGNavigationBarView *navigationBarView;
/** 是否隐藏导航栏 */
@property (nonatomic, assign) BOOL isNavigationBarHidden;
/** 是否隐藏导航栏，并且是否执行动画 */
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

/** 
 *  设置视图控制器的view 
 *  @param 子类可以重写该方法重新设置视图控制器的view
 */
- (void)setupView;
@end
NS_ASSUME_NONNULL_END