//
//  CGTitleButtonView.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGTitleButtonView.h"

#import "UIButton+CGCreateCustomButton.h"

@interface CGTitleButtonView ()

@property (strong, nonatomic, readwrite) CGBaseButton *titleButton;
@end

@implementation CGTitleButtonView

- (void)initialization
{
    self.singleTitleView = self.titleButton;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.titleButton.superview ?: [self addSubview:self.titleButton];
    }
}

#pragma mark - 属性设置
- (CGBaseButton *)titleButton
{
    if (_titleButton) {
        return _titleButton;
    }
    
    _titleButton = [CGBaseButton cg_createDefaultButton];
    return _titleButton;
}

@end
