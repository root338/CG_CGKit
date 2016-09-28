//
//  CGTitleImageLayoutView.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGDoubleLayoutBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGTitleImageLayoutView : CGDoubleLayoutBaseView

@property (nonatomic, strong, readonly) UIImageView * imageView;
@property (nonatomic, strong, readonly) UILabel     * titleLabel;

/** 第一个视图为图像， 默认为NO */
@property (nonatomic, assign) BOOL firstItemIsTitleLabel;

@end

NS_ASSUME_NONNULL_END
