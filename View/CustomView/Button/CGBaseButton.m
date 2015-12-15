//
//  CGBaseButton.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseButton.h"

#import "CGBorderBaseLayer.h"

#import "CGPrintLogHeader.h"

@interface CGBaseButton ()
{
    
}

@property (nonatomic, strong, readonly) CGBorderBaseLayer *borderLayer;

@end

@implementation CGBaseButton

@synthesize isDisableStateOfDisableUserInteraction = _isDisableStateOfDisableUserInteraction;

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



+ (Class)layerClass
{
    return [CGBorderBaseLayer class];
}

#pragma mark - CGViewSetupBorderStateDelegate
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
