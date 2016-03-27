//
//  CGAddSubviewsErrorTypeHeader.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGAddSubviewsErrorTypeHeader_h
#define CGAddSubviewsErrorTypeHeader_h

/**
 *  添加子视图错误的类型
 */
typedef NS_ENUM(NSInteger, CGAddSubviewsErrorType) {
    
    /** 未知错误 */
    CGAddSubviewsErrorTypeUnknown   = -1,
    /** 没有错误 */
    CGAddSubviewsErrorTypeNone,
    /** 必要条件不满足*/
    CGAddSubviewsErrorTypePrivate,
    /** 视图宽度为0 */
    CGAddSubviewsErrorTypeViewWidthZero,
    /** 无法计算视图宽度 */
    CGAddSubviewsErrorTypeUnknownViewWidth,
    /** 计算的宽度与视图宽度不兼容 */
    CGAddSubviewsErrorTypeWidthNotCompatible,
    /** 视图高度为0 */
    CGAddSubviewsErrorTypeViewHeightZero,
    /** 无法计算视图高度 */
    CGAddSubviewsErrorTypeUnknownViewHeight,
    /** 计算的高度与视图高度不兼容 */
    CGAddSubviewsErrorTypeHeightNotCompatible,
};

///**
// *  视图的返回类型
// */
//typedef NS_ENUM(NSInteger, CGAddSubviewsType) {
//    
//    /** 父视图宽度 */
//    CGAddSubviewsTypeMaxWidth,
//    /** 父视图高度 */
//    CGAddSubviewsTypeMaxHeight,
//    /** 子视图宽度 */
//    CGAddSubviewsTypeItemWidth,
//    /** 子视图高度 */
//    CGAddSubviewsTypeItemHeight,
//};

#endif /* CGAddSubviewsErrorTypeHeader_h */
