//
//  CGTitleImageLayoutView.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN


@interface CGTitleImageLayoutView : CGBaseView

@property (nonatomic, strong, readonly) UIImageView * imageView;

@property (nonatomic, strong, readonly) UILabel     * titleLabel;

@end

NS_ASSUME_NONNULL_END