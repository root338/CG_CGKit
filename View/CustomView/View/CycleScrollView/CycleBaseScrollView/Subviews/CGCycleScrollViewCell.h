//
//  CGCycleScrollViewCell.h
//  TestCG_CGKit
//
//  Created by DY on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGCycleScrollViewCell : UIView

@property (nullable, nonatomic, copy, readonly) NSString *resueIdentifier;

@property (nonatomic, strong, readonly) UIView *contentView;

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END