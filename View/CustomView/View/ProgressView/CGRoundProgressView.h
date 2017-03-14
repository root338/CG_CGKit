//
//  CGRoundProgressView.h
//  QuickAskCommunity
//
//  Created by DY on 2017/3/14.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGRoundProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nullable, nonatomic, strong) UIColor *progressTintColor;
@property (nullable, nonatomic, strong) UIColor *trackTintColor;

@end

NS_ASSUME_NONNULL_END
