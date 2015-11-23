//
//  UIScrollView+CGCreate.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CGCreate.h"

@interface UIScrollView (CGCreate)

/**
 *  创建滑动视图（滑动条显隐，是否分页）
 *
 *  @param showScrollIndicator 横竖滑动条显隐
 *  @param paramPagingEnabled  是否分页
 */
+ (instancetype)cg_createWithScrollViewWithShowScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled;


/**
 *  创建滑动视图（区域，滑动条显隐，是否分页）
 *
 *  @param frame               显示区域
 *  @param showScrollIndicator 横竖滑动条显隐
 *  @param paramPagingEnabled  是否分页
 */
+ (instancetype)cg_createWithScrollViewWithFrame:(CGRect)frame showScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled;

@end
