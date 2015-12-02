//
//  CGSingleTitleBaseView.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseView.h"

/** 单标题视图基类 */
@interface CGSingleTitleBaseView : CGBaseView

/** 标题距离视图四周的距离 */
@property (assign, nonatomic) UIEdgeInsets marginEdgeInsets;

/** 单标题视图的弱引用 */
@property (weak, nonatomic) UIView *singleTitleView;


@end
