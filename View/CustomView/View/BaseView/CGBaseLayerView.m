//
//  CGBaseLayerView.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseLayerView.h"
#import "CGBorderBaseLayer.h"


@interface CGBaseLayerView ()
{
    
}

@property (nonatomic, strong, readonly) CGBorderBaseLayer *borderLayer;
@end

@implementation CGBaseLayerView

+ (Class)layerClass
{
    return [CGBorderBaseLayer class];
}

- (CGBorderObject *)borderLayerForState:(CGViewBorderState)state
{
    return [self borderLayerForState:state];
}

- (void)setViewWithBorderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state
{
    [self.borderLayer cg_setupBorderWithColor:color borderWidth:borderWidth state:state];
}

- (void)setViewWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state
{
    [self.borderLayer cg_setupBorderWithBorderObject:borderObject state:state];
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
    return self.borderLayer.borderState;
}

- (void)setBorderState:(CGViewBorderState)borderState
{
    self.borderLayer.borderState = borderState;
    [self changeUserInteraction];
}

- (void)setIsDisableStateOfDisableUserInteraction:(BOOL)isDisableStateOfDisableUserInteraction
{
    if (isDisableStateOfDisableUserInteraction != _isDisableStateOfDisableUserInteraction) {
        _isDisableStateOfDisableUserInteraction = isDisableStateOfDisableUserInteraction;
        [self changeUserInteraction];
    }
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
