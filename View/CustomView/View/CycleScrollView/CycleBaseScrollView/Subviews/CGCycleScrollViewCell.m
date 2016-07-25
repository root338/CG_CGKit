//
//  CGCycleScrollViewCell.m
//  TestCG_CGKit
//
//  Created by DY on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCycleScrollViewCell.h"

#import "CGCycleScrollView.h"

#import "UIView+CGSearchView.h"
#import "UIView+CGAddConstraints.h"

@interface CGCycleScrollViewCell ()

@property (nullable, nonatomic, copy, readwrite) NSString *resueIdentifier;

@property (nonatomic, strong, readwrite) UIView *contentView;

@property (nonatomic, strong) UIButton *cellClickButton;
@end

@implementation CGCycleScrollViewCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _resueIdentifier    = reuseIdentifier;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self    = [super initWithFrame:frame];
    if (self) {
        
        _contentView    = [[UIView alloc] init];
        [_contentView cg_autoEdgesInsetsZeroToSuperview];
        
        _cellClickButton    = [UIButton buttonWithType:UIButtonTypeSystem];
        [_contentView addSubview:_cellClickButton];
        [_cellClickButton addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [_cellClickButton cg_autoEdgesInsetsZeroToSuperview];
    }
    return self;
}

- (void)handleClick:(UIButton *)sender
{
    CGCycleScrollView *scrollView = [self searchSuperViewWithClass:[CGCycleScrollView class]];
    if ([scrollView.delegate respondsToSelector:@selector(cycleScrollView:didSelectRowAtIndex:)]) {
        [scrollView.delegate cycleScrollView:scrollView didSelectRowAtIndex:0];
    }
}

@end
