//
//  CGLabelsLayoutView.h
//  QuickAskCommunity
//
//  Created by apple on 2018/4/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "CGDoubleLayoutBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGLabelsLayoutView : CGDoubleLayoutBaseView

@property (nonatomic, strong, readonly) UILabel *firstLabel;

@property (nonatomic, strong, readonly) UILabel *secondLabel;

@end

NS_ASSUME_NONNULL_END
