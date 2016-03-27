//
//  CGSubviewsSizeAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAddSubviewsAppearance.h"

/**
 *  一个视图添加多个相同视图时的全局设置，通过设置子视图大小来设置布局
 *  @param 前提条件：父视图大小确定
 *  @param 实现原理：通过父视图大小，外边距和子视图大小来计算水平，垂直间距。来添加子视图
 */
NS_CLASS_DEPRECATED_IOS(2_0, 2_0, "暂时没有任何其他类使用")
@interface CGSubviewsSizeAppearance : CGAddSubviewsAppearance

/** 子视图的大小 */
@property (nonatomic, assign) CGSize itemSize;

@end
