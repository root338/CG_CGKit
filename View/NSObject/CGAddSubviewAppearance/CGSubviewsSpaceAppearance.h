//
//  CGSubviewsSpaceAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGAddSubviewsAppearance.h"

/**
 *  一个视图添加多个相同视图时的全局设置，通过设置子视图之间的间距来设置布局
 *  实现方式1： 父视图大小确定，通过父视图大小，外边距和子视图水平，垂直间距来计算子视图大小。从而添加子视图
 *  实现方式2： 父视图宽度确定，通过父视图大小，外边距和子视图水平间距计算子视图宽度，通过子视图宽度和宽高比计算子视图高度，来添加子视图
 */
__deprecated_msg("暂时没有任何其他类使用")
@interface CGSubviewsSpaceAppearance : CGAddSubviewsAppearance

/** 使用子视图宽高比来计算视图布局 */
@property (nonatomic, assign) BOOL useSubviewScale;
/** 子视图之间的宽度/高度的比例 itemScal = width / height */
@property (nonatomic, assign) CGFloat itemScale;

@end
