//
//  NSString+InteractivePopEnable.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/9.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (InteractivePopEnable)

/** 打开或关闭 系统横滑弹出 */
-(void) baseInteractivePopGestureRecognizerEnable:(BOOL)enable;

@end
