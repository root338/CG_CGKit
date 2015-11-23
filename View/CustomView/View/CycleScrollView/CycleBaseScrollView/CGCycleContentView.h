//
//  CGCycleContentView.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 循环滑动视图的内容视图 */
@interface CGCycleContentView : UIView

/** 内容视图 */
@property (strong, nonatomic) UIView *contentView;

/** 视图索引 */
@property (assign, nonatomic) NSInteger viewIndex;

/** 创建滑动单个视图 */
+ (instancetype)cg_createCycleContentViewWithContentView:(UIView *)contentView index:(NSInteger)index;
@end
