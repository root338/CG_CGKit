//
//  CGBorderButtonLayer.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CGViewBorderStateProtocol.h"

@class CGBorderObject;

/** 
 *  设置视图层的边框值
 *  其他UIView可以实现layerClass类方法来使用该层
 */
@interface CGBorderBaseLayer : CALayer

/** 
 *  当前层的状态 
 *  可通过设置它来改变边框的不同值
 */
@property (nonatomic, assign) CGViewBorderState borderState;

/** 获取指定状态下的边框对象 */
- (CGBorderObject *)borderObjectForState:(CGViewBorderState)state;

/** 设置边框 （UIColor， CGFloat） */
- (void)cg_setupBorderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state;

/** 设置边框 （CGBorderObject） */
- (void)cg_setupBorderWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state;
@end
