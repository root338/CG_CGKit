//
//  CGRadioTitleCellAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 16/8/11.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
/** 单选视图子视图的外观设置 */
@interface CGRadioTitleCellAppearance : NSObject

//标题设置
@property (nullable, nonatomic, strong) UIColor *titleNormalColor;
@property (nullable, nonatomic, strong) UIColor *titleSelectColor;

@property (nullable, nonatomic, strong) UIFont  *titleFont;



@end
NS_ASSUME_NONNULL_END