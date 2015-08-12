//
//  UIView+LayoutSetupHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/11.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#ifndef QuickAskCommunity_UIView_LayoutSetupHeader_h
#define QuickAskCommunity_UIView_LayoutSetupHeader_h

/**
 *  视图布局的状态
 */
typedef NS_OPTIONS(NSInteger, CGViewLayoutType){
    /**
     *  不进行任何设置
     */
    CGViewLayoutTypeNone                = 0,
    /**
     *  等宽
     */
    CGViewLayoutTypeEqualWidth          = 1 << 0,
    /**
     *  等高
     */
    CGViewLayoutTypeEqualHeight         = 1 << 1,
    
    /**
     *  顶部相等
     */
    CGViewLayoutTypeEqualTop            = 1 << 2,
    
    /**
     *  左边相等
     */
    CGViewLayoutTypeEqualLeading        = 1 << 3,
    
    /**
     *  底部相等
     */
    CGViewLayoutTypeEqualBottom         = 1 << 4,
    
    /**
     *  右边相等
     */
    CGViewLayoutTypeEqualTrailing       = 1 << 5,
    
    /**
     *  水平等高
     */
    CGViewLayoutTypeLevelEqualHeight    = CGViewLayoutTypeEqualTop | CGViewLayoutTypeEqualBottom,
    
    
    
    /**
     *  大小相等
     */
    CGViewLayoutTypeEqualSize           = CGViewLayoutTypeEqualWidth | CGViewLayoutTypeEqualHeight,
};

/**
 *  子视图布局类型，包含与父视图之间的布局
 */
typedef NS_ENUM(NSInteger, CGLayoutType){
    /**
     *  空
     */
    CGLayoutTypeNone,
    /**
     *  垂直下
     */
    CGLayoutTypeVertical,
    /**
     *  水平下
     */
    CGLayoutTypeHorizontal,
    /**
     *  最后视图距离父视图是 >= 的距离
     */
    CGLayoutTypeHorizontalLastGreaterThanOrEqualTo,
};

/**
 *  视图相对于父视图的约束设置
 */
typedef NS_OPTIONS(NSInteger, CGLayoutForSuperViewType){
    /**
     *  顶部约束
     */
    CGLayoutForSuperViewTypeTop             = 1 << 0,
    /**
     *  左边约束
     */
    CGLayoutForSuperViewTypeLeft            = 1 << 1,
    /**
     *  下边约束
     */
    CGLayoutForSuperViewTypeBottom          = 1 << 2,
    /**
     *  右边约束
     */
    CGLayoutForSuperViewTypeRight           = 1 << 3,
    /**
     *  左边和右边约束
     */
    CGLayoutForSuperViewTypeHorizontal      = CGLayoutForSuperViewTypeLeft  | CGLayoutForSuperViewTypeRight,
    /**
     *  顶部与底部约束
     */
    CGLayoutForSuperViewTypeVertical        = CGLayoutForSuperViewTypeTop   | CGLayoutForSuperViewTypeBottom,
    /**
     *  除顶部的其他约束
     */
    CGLayoutForSuperViewTypeExcludeTop      = CGLayoutForSuperViewTypeHorizontal    | CGLayoutForSuperViewTypeBottom,
    /**
     *  除左边的其他约束
     */
    CGLayoutForSuperViewTypeExcludeLeft     = CGLayoutForSuperViewTypeVertical      | CGLayoutForSuperViewTypeRight,
    /**
     *  除底部的其他约束
     */
    CGLayoutForSuperViewTypeExcludeBottom   = CGLayoutForSuperViewTypeHorizontal    | CGLayoutForSuperViewTypeTop,
    /**
     *  除右边的其他约束
     */
    CGLayoutForSuperViewTypeExcludeRight    = CGLayoutForSuperViewTypeVertical      | CGLayoutForSuperViewTypeLeft,
    /**
     *  四边所有约束
     */
    CGLayoutForSuperViewTypeAll             = CGLayoutForSuperViewTypeHorizontal    | CGLayoutForSuperViewTypeVertical,
};

#endif
