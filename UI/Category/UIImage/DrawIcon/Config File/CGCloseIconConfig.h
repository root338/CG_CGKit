//
//  CGCloseIconConfig.h
//  TestCG_CGKit
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGIconConfig.h"

NS_ASSUME_NONNULL_BEGIN
//X型关闭图片配置
@interface CGCloseIconConfig : CGIconConfig

/** X型 上边角的角度值, 默认值为0，即绘制两条对角线 */
@property (nonatomic, assign) CGFloat angle;

+ (instancetype)defalutCloseConfig;
@end

NS_ASSUME_NONNULL_END
