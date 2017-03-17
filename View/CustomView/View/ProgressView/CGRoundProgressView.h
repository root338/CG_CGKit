//
//  CGRoundProgressView.h
//  QuickAskCommunity
//
//  Created by DY on 2017/3/14.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 圆形进度条视图 */
@interface CGRoundProgressView : UIView

/** 加载的进度 [0, 1] */
@property (nonatomic, assign) CGFloat progress;

/** 半径，默认 30 */
@property (nonatomic, assign) CGFloat radius;

/** 宽度，默认 5 */
@property (nonatomic, assign) CGFloat lineWidth;

/** 进度条颜色，默认，白色 */
@property (nonatomic, strong) UIColor *progressTintColor;
//@property (nullable, nonatomic, strong) UIColor *trackTintColor;

@end

NS_ASSUME_NONNULL_END
