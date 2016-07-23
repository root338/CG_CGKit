//
//  CGLayoutMarginDelegate.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

/** 单个视图 由基类进行布局，子类提供相应视图的协议 */
@protocol CGLayoutMarginDelegate <NSObject>

- (UIView *)cg_layoutMarginTargetView;

@optional
- (instancetype)initWithMarginEdgeInstes:(UIEdgeInsets)marginEdgeInstes;

@end

/** 两个视图 由基类进行布局，子类提供相应视图的协议 */
@protocol CGDoubleLayoutDelegate <NSObject>

/** 两个视图之间的间距 */
@property (nonatomic, assign) CGFloat targetViewsBetweenSapce;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;
/** 第一个视图的外边距 */
@property (nonatomic, assign) UIEdgeInsets firstTargetViewEdgeInsets;
/** 第二个视图的外边距 */
@property (nonatomic, assign) UIEdgeInsets secondTargetViewEdgeInsets;

/** 第一个视图 */
- (UIView *)cg_layoutFirstTargetView;
/** 第二个视图 */
- (UIView *)cg_layoutSecondTargetView;

@end