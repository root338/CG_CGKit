//
//  CGBaseNavigationControllerDelegate.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/21.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 导航栏的自定义代理方法 */
@protocol CGBaseNavigationControllerDelegate <NSObject>

@optional
/** 是否隐藏导航栏的UINavigationBar */
- (BOOL)hideNavigationBarWithNavigationController:(UINavigationController *)navigationController;

@end
