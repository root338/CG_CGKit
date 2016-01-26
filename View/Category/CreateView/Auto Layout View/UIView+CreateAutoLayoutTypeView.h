//
//  UIView+CreateAutoLayoutTypeView.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/12.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 创建支持 AutoLayout 的视图 */
@interface UIView (CreateAutoLayoutTypeView)

+ (instancetype)newAutoLayoutView;

@end
NS_ASSUME_NONNULL_END