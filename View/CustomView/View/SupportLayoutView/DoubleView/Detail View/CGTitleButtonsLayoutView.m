//
//  CGTitleButtonsLayoutView.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitleButtonsLayoutView.h"

#import "UIView+CGAddConstraints.h"

@interface CGTitleButtonsLayoutView ()

@property (nonatomic, strong, readwrite) UIButton *firstButton;

@property (nonatomic, strong, readwrite) UIButton *secondButton;

@end

@implementation CGTitleButtonsLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _firstButton    = [UIButton buttonWithType:UIButtonTypeSystem];
        _secondButton     = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [self addSubview:_firstButton];
        [self addSubview:_secondButton];
    }
    
    return self;
}

#pragma mark - CGDoubleLayoutDelegate
- (UIView *)cg_layoutFirstTargetView
{
    return self.firstButton;
}

- (UIView *)cg_layoutSecondTargetView
{
    return self.secondButton;
}

#pragma mark - 设置属性



@end
