//
//  CGCycleContentView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/23.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGCycleContentView.h"
#import "CGCycleScrollView.h"

#import "UIView+CGCreate.h"
#import "UIView+CGSearchView.h"

@interface CGCycleContentView ()
{
    
}

@property (strong, nonatomic) UIButton *cycleContentButton;
@end

@implementation CGCycleContentView

+ (instancetype)cg_createCycleContentViewWithContentView:(UIView *)contentView index:(NSInteger)index
{
    CGCycleContentView *cycleContentView    = [self cg_createView];
    
    cycleContentView.contentView            = contentView;
    
    cycleContentView.viewIndex              = index;
    
    return cycleContentView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.frame          = self.bounds;
    self.cycleContentButton.frame   = self.bounds;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        
        self.cycleContentButton.superview ?: [self insertSubview:self.cycleContentButton atIndex:0];
        self.cycleContentButton.frame = self.bounds;
    }
}

#pragma mark - 事件
- (void)handleClickAction:(id)sender
{
    CGCycleScrollView *scrollView = [self searchSuperViewWithClass:[CGCycleScrollView class]];
    if ([scrollView.delegate respondsToSelector:@selector(cycleScrollView:didSelectRowAtIndex:)]) {
        [scrollView.delegate cycleScrollView:scrollView didSelectRowAtIndex:self.viewIndex];
    }
}

#pragma mark - 设置属性
- (void)setContentView:(UIView *)contentView
{
    if (contentView != _contentView) {
        if (_contentView.superview) {
            [_contentView removeFromSuperview];
        }
        
        _contentView = contentView;
        
        [self addSubview:contentView];
        contentView.frame = self.bounds;
    }
}

- (UIButton *)cycleContentButton
{
    if (_cycleContentButton) {
        return _cycleContentButton;
    }
    
    _cycleContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cycleContentButton addTarget:self action:@selector(handleClickAction:) forControlEvents:UIControlEventTouchUpInside];
    return _cycleContentButton;
}
@end
