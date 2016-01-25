//
//  UIView+CGBorderLayer.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/15.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UIView+CGBorderLayer.h"
#import "CGBorderObject.h"
#import "CGBorderBaseLayer.h"

#import <objc/runtime.h>

@implementation UIView (CGBorderLayer)

@dynamic isDisableStateOfDisableUserInteraction;

#pragma mark - CGViewSetupBorderState
- (CGBorderObject *)borderLayerForState:(CGViewBorderState)state
{
    return [[self borderLayer] borderObjectForState:state];
}

- (void)setViewWithBorderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state
{
    [[self borderLayer] cg_setupBorderWithColor:color borderWidth:borderWidth state:state];
}

- (void)setViewWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state
{
    [[self borderLayer] cg_setupBorderWithBorderObject:borderObject state:state];
}

- (void)changeUserInteraction
{
    BOOL enable = YES;
    if (self.isDisableStateOfDisableUserInteraction && self.borderState == CGViewBorderStateDisabled ) {
        enable = NO;
    }
    
    if (self.userInteractionEnabled != enable) {
        self.userInteractionEnabled = enable;
    }
}

#pragma mark - 设置属性
- (CGViewBorderState)borderState
{
    return [self borderLayer].borderState;
}

- (void)setBorderState:(CGViewBorderState)borderState
{
    [self borderLayer].borderState = borderState;
    [self changeUserInteraction];
}

- (void)setIsDisableStateOfDisableUserInteraction:(BOOL)isDisable
{
    objc_setAssociatedObject(self, @selector(isDisableStateOfDisableUserInteraction), @(isDisable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isDisableStateOfDisableUserInteraction
{
    return objc_getAssociatedObject(self, _cmd);
}

- (CGBorderBaseLayer *)borderLayer
{
    CGBorderBaseLayer *borderLayer = nil;
    if ([self.layer isKindOfClass:[CGBorderBaseLayer class]]) {
        borderLayer = (id)self.layer;
    }
    return borderLayer;
}

@end
