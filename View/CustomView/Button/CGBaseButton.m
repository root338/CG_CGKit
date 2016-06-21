//
//  CGBaseButton.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseButton.h"

#import "CGBorderBaseLayer.h"
#import "UIView+CGBorderLayer.h"
#import "UIView+CGSetupAppearance.h"

#import "CGPrintLogHeader.h"

//const CGFloat __K_Button_AutoBorderWidth = FLT_MAX;

@interface CGBaseButton ()
{
    
}

@end

@implementation CGBaseButton

#pragma mark - 创建UIButton
+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    CGBaseButton *button = [super buttonWithType:buttonType];
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

- (void)initialization
{
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self cg_borderSyncTitle];
    }
}

- (void)cg_borderSyncTitle
{
    UIControlState controlState = [self cg_controlStateForState:self.state];
    if (self.isBorderColorSyncTitle) {
        
        CGViewBorderState stateForBorder = [self cg_borderStateForControlState:controlState];
        [self setViewWithBorderColor:self.currentTitleColor borderWidth:self.borderWidth state:stateForBorder];
        self.borderState = stateForBorder;
    }else {
        
        self.borderState = [self cg_borderStateForControlState:controlState];
    }
}

#pragma mark - 重写系统状态改变方法
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self cg_borderSyncTitle];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted && !self.isBorderColorSyncTitle) {
        if (![self borderLayerForState:CGViewBorderStateHighlighted]) {
            return;
        }
    }
    
    [self cg_borderSyncTitle];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self cg_borderSyncTitle];
}

#pragma mark - 层设置方法
+ (Class)layerClass
{
    return [CGBorderBaseLayer class];
}

/** 过滤复合状态，提取优先级最高的状态值 */
- (UIControlState)cg_controlStateForState:(UIControlState)state
{
    UIControlState controlState;
    if (state & UIControlStateHighlighted) {
        
        controlState = UIControlStateHighlighted;
    }else if (state & UIControlStateDisabled) {
        
        controlState = UIControlStateDisabled;
    }else if (state & UIControlStateSelected) {
        
        controlState = UIControlStateSelected;
    }else {
        
        controlState = UIControlStateNormal;
    }
    
    return controlState;
}

- (CGViewBorderState)cg_borderStateForControlState:(UIControlState)state
{
    UIControlState controlState = [self cg_controlStateForState:state];
    CGViewBorderState tempState;
    switch (controlState) {
        
        case UIControlStateHighlighted:
            tempState   = CGViewBorderStateHighlighted;
            break;
        case UIControlStateSelected:
            tempState   = CGViewBorderStateSelected;
            break;
        case UIControlStateDisabled:
            tempState   = CGViewBorderStateDisabled;
            break;
        default:
            CGErrorConditionLog(state != UIControlStateNormal, @"边框属性不支持该属性(%li)", (unsigned long)state);
            tempState = CGViewBorderStateNormal;
            break;
    }
    
    return tempState;
}

- (CGBorderObject *)cg_borderObjectForState:(UIControlState)state
{
    return [self borderLayerForState:[self cg_borderStateForControlState:state]];
}

- (void)cg_setupBorderWithColor:(UIColor *)borderColor state:(UIControlState)state
{
    [self cg_setupBorderWithColor:borderColor width:self.borderWidth state:state];
}

- (void)cg_setupBorderWithColor:(UIColor *)borderColor width:(CGFloat)width state:(UIControlState)state
{
    [self setViewWithBorderColor:borderColor borderWidth:width state:[self cg_borderStateForControlState:state]];
}

- (void)cg_setupBorderWithObject:(CGBorderObject *)borderObject state:(UIControlState)state
{
    [self setViewWithBorderObject:borderObject state:[self cg_borderStateForControlState:state]];
}

@end
