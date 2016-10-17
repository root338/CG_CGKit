//
//  CGArrowIconConfig.h
//  TestCG_CGKit
//
//  Created by DY on 16/10/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGIconConfig.h"
#import "CGOrientationTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 配置文件的类型 */
typedef NS_ENUM(NSInteger, CGArrowIconConfigType) {
    
    /** 以父类给定大小和给定的angle来进行计算箭头的内容 */
    CGArrowIconConfigTypeNone,
    /** 以父类 size 和 angle 来进行计算，并裁减多余的空白区域 */
    CGArrowIconConfigTypeDefaultCropOverSize,
    /** 以给定的arrowVertex, LeftVertex, rightVertex三点坐标进行绘制 */
    CGArrowIconConfigTypeFixedPoint,
};

//箭头配置
@interface CGArrowIconConfig : CGIconConfig

/** 箭头的绘制类型, 默认为CGArrowIconConfigTypeDefaultCropOverSize */
@property (nonatomic, assign) CGArrowIconConfigType configType;

/** 箭头的方向，默认CGOrientationTypeLeft */
@property (nonatomic, assign) CGOrientationType arrowVertexOrientationType;

/** 箭头角度(1, 180]，默认为90 */
@property (nonatomic, assign) CGFloat angle;

///** 
// *  箭头偏移的的值，默认为0
// *  @warning    为了防止箭头的箭头没有全部绘制，而出现平箭头现象
// *  @param      使用父类marginEdgeInset属性替换
// */
//@property (nonatomic, assign) CGFloat arrowVertexOffset;

//-----自定义设置相对于箭头的左右坐标，自定义时其他属性将被忽略
//-----仅在CGArrowIconConfigTypeFixedPoint值下有效

@property (nonatomic, assign) CGPoint arrowVertex;
@property (nonatomic, assign) CGPoint LeftVertex;
@property (nonatomic, assign) CGPoint rightVertex;

+ (instancetype)defaultArrowConfig;
@end

NS_ASSUME_NONNULL_END
