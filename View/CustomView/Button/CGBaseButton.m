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
    /// 已经设置的高亮等于的其他状态
    UIControlState _didSetHighlightedEqualState;
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

//- (void)_changeHighlightedStatusToState:(UIControlState)state {
//    if (_didSetHighlightedEqualState == state) {
//        return;
//    }
//    
//    NSString *title = [self titleForState:state];
//    UIColor *titleColor = [self titleColorForState:state];
//    UIColor *titleShadowColor = [self titleShadowColorForState:state];
//    UIImage *image = [self imageForState:state];
//    UIImage *backgroundImage = [self backgroundImageForState:state];
//    NSAttributedString *attributedTitle = [self attributedTitleForState:state];
//    
//    UIControlState highlightedState = UIControlStateHighlighted;
//    NSString *highlightedTitle = [self titleForState:highlightedState];
//    UIColor *highlightedTitleColor = [self titleColorForState:highlightedState];
//    UIColor *highlightedTitleShadowColor = [self titleShadowColorForState:highlightedState];
//    UIImage *highlightedImage = [self imageForState:highlightedState];
//    UIImage *highlightedBackgroundImage = [self backgroundImageForState:highlightedState];
//    NSAttributedString *highlightedAttributedTitle = [self attributedTitleForState:highlightedState];
//    
//    if (title != highlightedTitle) {
//        [self setTitle:title forState:highlightedState];
//    }
//    if (attributedTitle != highlightedAttributedTitle) {
//        [self setAttributedTitle:attributedTitle forState:highlightedState];
//    }
//    if (titleColor != highlightedTitleColor) {
//        [self setTitleColor:titleColor forState:highlightedState];
//    }
//    if (titleShadowColor != highlightedTitleShadowColor) {
//        [self setTitleShadowColor:titleShadowColor forState:highlightedState];
//    }
//    if (image != highlightedImage) {
//        [self setImage:image forState:highlightedState];
//    }
//    if (backgroundImage != highlightedBackgroundImage) {
//        [self setBackgroundImage:backgroundImage forState:highlightedState];
//    }
//    _didSetHighlightedEqualState = state;
//}

#pragma mark - 重写系统状态改变方法
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self cg_borderSyncTitle];
//    if (_enableHighlightedStatusSyncFinalStatus) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (self.selected == selected) {
//                [self _changeHighlightedStatusToState:self.selected ? UIControlStateSelected : UIControlStateNormal];
//            }
//        });
//    }
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
