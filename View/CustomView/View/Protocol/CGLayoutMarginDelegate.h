//
//  CGLayoutMarginDelegate.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

/** 由基类进行布局，子类提供相应视图的协议 */
@protocol CGLayoutMarginDelegate <NSObject>

- (UIView *)cg_layoutMarginTargetView;

@end
