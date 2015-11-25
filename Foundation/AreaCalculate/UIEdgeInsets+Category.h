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
UIEdgeInsets UIEdgeInsetsMakeAllEqualValue(CGFloat value);

/** 设置顶部数值，其他为0 */
UIEdgeInsets UIEdgeInsetsZeroMakeExcludeTop(CGFloat topValue);

/** 设置左边数值，其他为0 */
UIEdgeInsets UIEdgeInsetsZeroMakeExcludeLeft(CGFloat leftValue);

/** 设置底部数值，其他为0 */
UIEdgeInsets UIEdgeInsetsZeroMakeExcludeBottom(CGFloat bottomValue);

/** 设置右边数值，其他为0 */
UIEdgeInsets UIEdgeInsetsZeroMakeExcludeRight(CGFloat rightValue);

