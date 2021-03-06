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

/** 设置left、right值 其他为0 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsZeroMakeExcludeHorizontal(CGFloat horizontalValue) {
    return UIEdgeInsetsMake(0, horizontalValue, 0, horizontalValue);
}


/** 设置left、right值 其他为0 */
UIKIT_STATIC_INLINE UIEdgeInsets UIEdgeInsetsZeroMakeExcludeVertical(CGFloat verticalValue) {
    return UIEdgeInsetsMake(verticalValue, 0, verticalValue, 0);
}

/** 计算 left + right */
UIKIT_STATIC_INLINE CGFloat CG_CGUIEdgeInsetsHorizontal(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/** 计算 top + bottom */
UIKIT_STATIC_INLINE CGFloat CG_CGUIEdgeInsetsVertical(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

UIKIT_STATIC_INLINE UIEdgeInsets CG_CGUIEdgeInsetsAdd(UIEdgeInsets insets1, UIEdgeInsets insets2) {
    return UIEdgeInsetsMake(insets1.top + insets2.top, insets1.left + insets2.left, insets1.bottom + insets2.bottom, insets1.right + insets2.right);
}
