//
//  CGSingleTitleBaseView.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGTitleBaseView.h"
#import "UIView+CG_CGAreaCalculate.h"

@interface CGTitleBaseView  ()

/** 
 *  是否自动在layoutSubviews布局，默认为YES
 *  @warning 暂不提供外部设置，只能通过代理设置
 */
@property (assign, nonatomic) BOOL isAutoShouldLayoutSubviews;

@end

@implementation CGTitleBaseView

- (void)initialization
{
    _isAutoShouldLayoutSubviews = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.isAutoShouldLayoutSubviews = YES;
    if ([self.delegate respondsToSelector:@selector(shouldLayoutSubviewsTitleView:)]) {
        self.isAutoShouldLayoutSubviews = [self.delegate shouldLayoutSubviewsTitleView:self];
    }
    if (self.singleTitleView && self.isAutoShouldLayoutSubviews) {
        self.singleTitleView.frame = CG_CGRectWithMargin(self.bounds, self.marginEdgeInsets);
    }
}

#pragma mark - 设置属性

- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsets, _marginEdgeInsets)) {
        _marginEdgeInsets   = marginEdgeInsets;
        [self setNeedsLayout];
    }
}

@end
