//
//  CGMoveViewTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGMoveViewTypeHeader_h
#define CGMoveViewTypeHeader_h

/**
 *  线性动画方式
 */
typedef NS_ENUM(NSInteger, CGLineMoveViewType) {
    /**
     *  从参考视图顶部开始动画，移动到参考视图顶部
     */
    CGLineMoveViewTypeTop,
    /**
     *  从参考视图右边开始动画，移动到参考视图右边
     */
    CGLineMoveViewTypeRight,
    /**
     *  从参考视图底部开始动画，移动到参考视图底部
     */
    CGLineMoveViewTypeBottom,
    /**
     *  从参考视图左边开始动画，移动到参考视图左边
     */
    CGLineMoveViewTypeLeft,
};

/**
 *  视图缩放的动画方式
 */
typedef NS_ENUM(NSInteger, CGScaleViewType) {
    
    /**
     *  以视图中心为中点坐标进行缩放
     */
    CGScaleViewTypeCenterVertex,
    /**
     *  以视图顶部中点坐标进行缩放
     */
    CGScaleViewTypeTopVertex,
    /**
     *  以视图左边中点坐标进行缩放
     */
    CGScaleViewTypeLeftVertex,
    /**
     *  以视图底部中点坐标进行缩放
     */
    CGScaleViewTypeBottomVertex,
    /**
     *  以视图右边中点坐标进行缩放
     */
    CGScaleViewTypeRightVertex,
    /**
     *  以视图左上角坐标进行缩放
     */
    CGScaleViewTypeLeftTopVertex,
    /**
     *  以视图左下角坐标进行缩放
     */
    CGScaleViewTypeLeftBottomVertex,
    /**
     *  以视图右下角坐标进行缩放
     */
    CGScaleViewTypeRightBottomVertex,
    /**
     *  以视图右下角坐标进行缩放
     */
    CGScaleViewTypeRightTopVertex,
};

#endif /* CGMoveViewTypeHeader_h */
