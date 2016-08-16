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
{
    UIButtonType _buttonType;
}
@property (nonatomic, strong, readwrite) UIButton *firstButton;

@property (nonatomic, strong, readwrite) UIButton *secondButton;

@end

@implementation CGTitleButtonsLayoutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupCreateButtonsWithType:_buttonType];
    }
    
    return self;
}

- (instancetype)initwithButtonType:(UIButtonType)buttonType
{
    _buttonType = buttonType;
    return [self initWithFrame:CGRectZero];
}

- (void)setupCreateButtonsWithType:(UIButtonType)buttonType
{
    _firstButton    = [UIButton buttonWithType:buttonType];
    _secondButton   = [UIButton buttonWithType:buttonType];
    
    [self.contentView addSubview:_firstButton];
    [self.contentView addSubview:_secondButton];
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
