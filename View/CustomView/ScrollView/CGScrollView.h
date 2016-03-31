//
//  CGScrollView.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/10.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"
#import "CGScrollViewDirectionHeader.h"

NS_ASSUME_NONNULL_BEGIN
@interface CGScrollView : UIScrollView<CGViewInitializationProtocol>

/** 开启滑动视图滑动方向的监听 */
@property (nonatomic, assign) BOOL enableScrollDirectionMonitor;

/** 滑动视图的滑动方向 @param 必须 enableScrollDirectionMonitor 为 YES */
@property (nonatomic, assign, readonly) CGScrollDirectionType scrollDirectionType;

///** 添加内容视图 @param 是否为滑动视图添加内容视图，如果添加其他需要视图应该添加到内容视图上 */
//@property (nonatomic, assign) BOOL isAddContentView;
///** 内容视图 */
//@property (nonatomic, strong) UIView *contentView;

@end
NS_ASSUME_NONNULL_END