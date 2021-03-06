//
//  UIScrollView+CGInit.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIScrollView (CGSetupAppearance)

/** 显示横向，竖向滚动条 */
@property (nonatomic, assign, readwrite) BOOL showsScrollIndicator;

/**
 *  设置滑动视图（区域，滑动条显隐，是否分页）
 *
 *  @param frame               显示区域
 *  @param showScrollIndicator 横竖滑动条显隐
 *  @param paramPagingEnabled  是否分页
 */
- (void)cg_setupWithFrame:(CGRect)frame showScrollIndicator:(BOOL)showScrollIndicator pagingEnabled:(BOOL)paramPagingEnabled;

@end
NS_ASSUME_NONNULL_END