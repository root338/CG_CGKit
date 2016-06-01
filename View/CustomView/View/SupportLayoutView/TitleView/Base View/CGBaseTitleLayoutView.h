//
//  CGBaseTitleLayoutView.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/1.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGBaseTitleLayoutView : UIView

@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;

@property (nullable, nonatomic, weak) UIView *targetView;

@end

NS_ASSUME_NONNULL_END