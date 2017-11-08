//
//  CGMultilineLabel.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGMultilineLabel : UILabel

/** 创建0行Label */
+ (instancetype)cg_createZeroLinesLabel;
/** 创建指定行Label */
+ (instancetype)cg_createLabelWithNumberOfLines:(NSUInteger)numberOfLines;

@end

NS_ASSUME_NONNULL_END
