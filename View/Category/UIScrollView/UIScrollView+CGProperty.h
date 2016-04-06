//
//  UIScrollView+CGProperty.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/14.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 自定义滑动视图的常用属性 */
@interface UIScrollView (CGProperty)

/** 获取滑动视图的可视区域 */
@property (nonatomic, assign, readonly) CGRect scrollVisibleRect;

/** 计算滑动页数 */
- (NSInteger) cg_calculateScrollPage;
@end
NS_ASSUME_NONNULL_END