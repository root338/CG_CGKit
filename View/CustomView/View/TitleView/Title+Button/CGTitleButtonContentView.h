//
//  CGTitleButtonContentView.h
//  QuickAskCommunity
//
//  Created by DY on 16/2/17.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseView.h"

@class CGButton;
NS_ASSUME_NONNULL_BEGIN
/**
 *  标题加按钮
 *  标题与按钮视图居中父视图
 */
@interface CGTitleButtonContentView : CGBaseView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) CGButton *titleButton;

/** 标题最大大小，默认CGSizeZero，自适应 */
@property (nonatomic, assign) CGSize titleLabelMaxSize;
/** 标题按钮最大大小，默认CGSizeZero，自适应 */
@property (nonatomic, assign) CGSize titleButtonMaxSize;


/** 文本标题外边界 默认UIEdgeInsetsZero，上下居中 @warning right值无效*/
@property (nonatomic, assign) UIEdgeInsets titleLabelMarginEdgeInsets;
/** 文本标题是否垂直居中, 默认为YES @warning titleLabelMarginEdgeInsets属性中 top,bottom 不为 0 时自动设置为NO */
@property (nonatomic, assign) BOOL titleLabelVerticalCenter;

/** 按钮标题外边界 默认UIEdgeInsetsZero，上下居中 @warning left值无效 */
@property (nonatomic, assign) UIEdgeInsets titleButtonMarginEdgeInsets;
/** 按钮标题是否垂直居中, 默认为YES @warning titleButtonMarginEdgeInsets 属性中 top,bottom 不为 0 时自动设置为NO */
@property (nonatomic, assign) BOOL titleButtonVerticalCenter;

/** 文本标题与按钮之间的间距 默认为0，两端对齐 */
@property (nonatomic, assign) CGFloat space;

/** 是否两端对齐 默认为NO，使用两端对齐 */
@property (nonatomic, assign) BOOL cancelJustified;

@end
NS_ASSUME_NONNULL_END
