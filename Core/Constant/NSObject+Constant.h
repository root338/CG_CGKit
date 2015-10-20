//
//  NSObject+Constant.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/21.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 自动适配相关值

#pragma mark - 简单自动布局常量值
const UIViewAutoresizing UIViewAutoresizingFlexibleAllMargin;

const UIViewAutoresizing UIViewAutoresizingFlexibleSize;


#pragma mark - UIEdgeInsets 相关设置函数
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