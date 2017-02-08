//
//  CGLineView.h
//  QuickAskCommunity
//
//  Created by DY on 16/8/12.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseView.h"
#import "CGLineBoxTypeHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 
 *  线框视图
 */
@interface CGLineView : CGBaseView

@property (nonatomic, assign) LineBoxType lineType;

@property (nullable, nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong, readonly) UIView *contentView;

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets lineType:(LineBoxType)lineType;

- (instancetype)initWithFrame:(CGRect)frame lineType:(LineBoxType)lineType lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
