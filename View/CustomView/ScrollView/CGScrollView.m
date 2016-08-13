//
//  CGScrollView.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/10.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGScrollView.h"

#import "CGScrollViewDelegateManager.h"

@interface CGScrollView ()
{
    CGScrollViewDelegateManager *_delegateManager;
}

@property (nonatomic, assign, readwrite) CGScrollDirectionType scrollDirectionType;


@end

@implementation CGScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self    = [super initWithFrame:frame];
    if (self) {
        
        _delegateManager    = [[CGScrollViewDelegateManager alloc] init];
        super.delegate      = _delegateManager;
    }
    return self;
}

#pragma mark - 设置属性
- (void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
    _delegate_cg    = (id)delegate;
}

-(id<UIScrollViewDelegate>)delegate
{
    return self.delegate_cg;
}

- (CGScrollControlType)scrollControlType
{
    return _delegateManager.scrollControlType;
}

- (CGScrollDirectionType)scrollDirectionType
{
    return _delegateManager.scrollDirectionType;
}

- (CGFloat)verticalMeanVelocity
{
    return _delegateManager.verticalMeanVelocity;
}

- (CGFloat)horizontalMeanVelocity
{
    return _delegateManager.horizontalMeanVelocity;
}

@end
