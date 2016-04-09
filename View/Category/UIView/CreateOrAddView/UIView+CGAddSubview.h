//
//  UIView+CGAddSubview.h
//  QuickAskCommunity
//
//  Created by DY on 16/2/22.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIView (CGAddSubview)

- (void)cg_addSubviews:(NSArray<UIView *> *)subviews;

/**
 *  当视图的bounds为CGRectZero时不添加该视图，如果存在且bounds=CGRectZero时，移除该视图
 *  @param 返回视图是否可以添加
 */
- (BOOL)cg_addSubview:(UIView *)view;


@end
NS_ASSUME_NONNULL_END