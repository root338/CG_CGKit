//
//  UIViewController+CGFullscreenPopGesture.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 视图控制器全屏滑动设置 */
@interface UIViewController (CGFullscreenPopGesture)

/** 是否关闭横滑弹出功能 */
@property (nonatomic, assign) BOOL cg_interactivePopDisabled;

/** 点击坐标距离左边的有效间距，超出部分不能进行横滑弹出 */
@property (nonatomic, assign) CGFloat cg_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
