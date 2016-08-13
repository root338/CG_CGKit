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

/** 
 *  计算滑动页数 scale 超出页数多少计算为下一页或上一页 scale= [0, 1]
 *  @warning 不适用于有间距的UICollectionView
 */
- (NSInteger)cg_calculateScrollPageWithScale:(CGFloat)scale;

@end
NS_ASSUME_NONNULL_END