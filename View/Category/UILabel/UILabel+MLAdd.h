//
//  UILabel+MLAdd.h
//  QuickAskCommunity
//
//  Created by apple on 2018/6/1.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MLAdd)
/// 单个行高
@property (nonatomic, readonly) CGFloat ml_lineHeight;
/// 单个字的高度，
@property (nonatomic, readonly) CGFloat ml_wordHeight;
/// 行高 - 单个字
@property (nonatomic, readonly) CGFloat ml_offsetValue;
@end
