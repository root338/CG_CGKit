//
//  UIEdgeInsets+Category.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/25.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  当UIEdgeInsets的四边间距相等使用
 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsMakeAllEqualValue(CGFloat value) {
    
    return UIEdgeInsetsMake(value, value, value, value);
}

/** 设置顶部数值，其他为0 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsZeroMakeExcludeTop(CGFloat topValue){
    return UIEdgeInsetsMake(topValue, 0, 0, 0);
}

/** 设置左边数值，其他为0 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsZeroMakeExcludeLeft(CGFloat leftValue){
    return UIEdgeInsetsMake(0, leftValue, 0, 0);
}

/** 设置底部数值，其他为0 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsZeroMakeExcludeBottom(CGFloat bottomValue){
    return UIEdgeInsetsMake(0, 0, bottomValue, 0);
}

/** 设置右边数值，其他为0 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsZeroMakeExcludeRight(CGFloat rightValue){
    return UIEdgeInsetsMake(0, 0, 0, rightValue);
}

