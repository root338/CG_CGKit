//
//  CGCycleContentView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 循环滑动视图的内容视图 */
@interface CGCycleContentView : UIButton

/** 内容视图 */
@property (strong, nonatomic) UIView *contentView;

/** 视图索引 */
@property (assign, nonatomic) NSInteger viewIndex;

/** 外边界 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsets;

/** 创建滑动单个视图 */
+ (instancetype)cg_createCycleContentViewWithContentView:(UIView *)contentView index:(NSInteger)index;

/**
 *  创建单个视图
 *
 *  @param contentView      需要添加的视图
 *  @param index            视图索引
 *  @param marginEdgeInsets 添加的contentView与视图之间的边距
 *
 *  @return 返回创建好的视图
 */
+ (instancetype)cg_createCycleContentViewWithContentView:(UIView *)contentView index:(NSInteger)index marginEdgeInsets:(UIEdgeInsets)marginEdgeInsets;

+ (instancetype)buttonWithType:(UIButtonType)buttonType;
@end
