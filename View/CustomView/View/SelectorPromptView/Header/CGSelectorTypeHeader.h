//
//  CGSelectorTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 2016/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGSelectorTypeHeader_h
#define CGSelectorTypeHeader_h

/** 动画的状态 */
typedef NS_ENUM(NSInteger, CGViewAnimationStatus) {
    /** 未知 */
    CGViewAnimationStatusUnknowe    = -1,
    /** 静止 */
    CGViewAnimationStatusStill,
    /** 动画执行中 */
    CGViewAnimationStatusAniamtion,
};

/** 视图的状态 */
typedef NS_ENUM(NSInteger, CGViewStatus) {
    
    
    /** 未知 */
    //    CGViewStatusUnknowe     = -1,
    /** 显示 */
    CGViewStatusShow        = 1,
    /** 由显示过滤到隐藏状态，一般为动画执行过程 */
    CGViewStatusShowToHide,
    /** 隐藏 */
    CGViewStatusHide,
    /** 由隐藏过滤到显示状态，一般为动画执行过程 */
    CGViewStatusHideToShow,
};

#endif /* CGSelectorTypeHeader_h */
