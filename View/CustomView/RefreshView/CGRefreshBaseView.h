//
//  CGRefreshBaseView.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/26.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  刷新的状态
 */
typedef NS_ENUM(NSInteger, CGRefreshState){
    /**
     *  没有刷新
     */
    CGRefreshStateNormal,
    /**
     *  达到下拉刷新条件，但用户还没有松开手
     */
    CGRefreshStatePulling,
    /**
     *  即将进行下拉刷新
     */
    CGRefreshStateWillRefresh,
    /**
     *  正在刷新
     */
    CGRefreshStateRefreshing,
};

@interface CGRefreshBaseView : UIView

/** 刷新的状态变化 */
@property (assign, nonatomic) CGRefreshState refreshState;


@end
