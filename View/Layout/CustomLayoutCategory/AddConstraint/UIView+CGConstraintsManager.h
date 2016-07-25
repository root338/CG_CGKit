//
//  UIView+CGConstraintsManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGLayoutManager.h"

NS_ASSUME_NONNULL_BEGIN
/** 约束管理扩展 */
@interface UIView (CGConstraintsManager)

/** 管理约束对象 */
@property (nullable, nonatomic, strong) CGLayoutManager *layoutManager;


@end
NS_ASSUME_NONNULL_END