//
//  CGLayoutManager.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN
@class CGLayoutManager;

@protocol CGLayoutManagerDelegate <NSObject>

@optional


@end

/** 添加约束的管理类 */
@interface CGLayoutManager : CGBaseObject


@end

NS_ASSUME_NONNULL_END