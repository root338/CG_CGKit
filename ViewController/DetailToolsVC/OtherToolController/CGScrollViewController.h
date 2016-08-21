//
//  CGScrollViewController.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleBarViewController.h"

@interface CGScrollViewController : CGTitleBarViewController<UIScrollViewDelegate>

/** 关闭操作导航栏，向下滑动显示导航栏，向上滑动隐藏导航栏 */
@property (nonatomic, assign) BOOL disableScrollOperateNavigationBar;

@end
