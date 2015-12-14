//
//  CGBaseButton.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseButton.h"

#import "UIView+CGSetupAppearance.h"

#import "CGPrintLogHeader.h"

@interface CGBaseButton ()
{
    
}
@end

@implementation CGBaseButton

#pragma mark - 创建UIButton
+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    CGBaseButton *button = [self buttonWithType:buttonType];
    [button initialization];
    return button;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialization];
}

- (void)initialization
{
    
}

@end
