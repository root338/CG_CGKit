//
//  CGRefreshIconConfig.h
//  TestCG_CGKit
//
//  Created by DY on 2016/10/13.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGIconConfig.h"

NS_ASSUME_NONNULL_BEGIN

//绘制刷新按钮
@interface CGRefreshIconConfig : CGIconConfig

/** 开始角度，默认 0 */
@property (nonatomic, assign) CGFloat startAngle;
/** 结束角度，默认 270 */
@property (nonatomic, assign) CGFloat endAngle;

/** 刷新按钮的宽度，默认 lineWidth默认值的3倍 */
@property (nonatomic, assign) CGFloat arrowWidth;

@end

NS_ASSUME_NONNULL_END
