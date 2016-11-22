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

/** 导航栏回退按钮的类型 */
typedef NS_ENUM(NSInteger, CGInteractivePopGestureRecognizerType) {
    /** 系统默认 */
    CGInteractivePopGestureRecognizerTypeSystem,
    /** 支持全屏的自定义回退手势 */
    CGInteractivePopGestureRecognizerTypeFullScreen,
//    CGNavigationControllerPopGestureRecognizerTypeCustom,
};

@interface CGNavigationController : UINavigationController

@property (nullable, nonatomic, weak) id<CGNavigationAppearanceProtocol> appearanceDelegate;

/** 导航栏默认是否隐藏 */
//@property (nonatomic, assign) BOOL defaultNavigationBarHidden;

/** 导航栏默认的颜色 */
@property (nullable, nonatomic, strong) UIColor *defaultNavigationBarBackgroundColor;

/** 状态栏的默认样式 */
@property (nonatomic, assign) UIStatusBarStyle defaultStatusBarStyle;

//注释原因：在加载过程中会直接调用当前UIViewController中重写的方法，状态栏的显示样式会使用最上层的视图控制器
///** 状态栏默认是否隐藏 */
//@property (nonatomic, assign) BOOL defaultStatusBarHidden;
//
///** 导航栏默认的动画 */
//@property (nonatomic, assign) UIStatusBarAnimation defaultStatusBarAnimation;

/** 导航栏标题默认的样式 */
@property (nullable, nonatomic, strong) NSDictionary<NSString *, id> *defaultTitleTextAttributes;

/** 打开自定义实现视图控制器的push，pop 默认 NO */
//@property (nonatomic, assign) BOOL enableViewControllerManager;

/** 
 *  关闭全屏回退功能，开启系统默认回退功能，默认 YES
 */
@property (nonatomic, assign) BOOL enablePopGestureRecognizer;

/** 导航栏回退按钮的类型，默认 CGInteractivePopGestureRecognizerTypeFullScreen */
@property (nonatomic, assign) CGInteractivePopGestureRecognizerType interactivePopGestureRecognizerType;
@end
NS_ASSUME_NONNULL_END
