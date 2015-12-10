//
//  CGBorderBaseView.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBorderBaseView.h"

//辅助类
#import "CGBorderBaseLayer.h"
#import "CGBorderObject.h"

//辅助扩展
#import "UIView+CGSetupAppearance.h"

@interface CGBorderBaseView ()<CGViewBorderStateProtocol, CGBorderLayerDelegate>

@property (nonatomic, strong, readonly) CGBorderBaseLayer *borderLayer;

@property (nonatomic, strong) NSMutableDictionary<NSNumber*, CGBorderObject *> *borderDict;
@end

@implementation CGBorderBaseView

+ (Class)layerClass
{
    return [CGBorderBaseLayer class];
}

- (void)initialization
{
    self.borderLayer.cg_delegate = self;
}

#pragma mark - 状态值转换、保存
- (void)cg_setupBorderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state
{
    [self cg_setupBorderWithBorderObject:[CGBorderObject cg_createBorderWithColorObject:borderColor width:borderWidth] state:state];
}

- (void)cg_setupBorderWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state
{
    !borderObject ?: [self.borderDict setObject:borderObject forKey:[self cg_keyWithState:state]];
}

//状态转key值
- (NSNumber *)cg_keyWithState:(CGViewBorderState)state
{
    return @(state);
}

#pragma mark - CGViewBorderStateProtocol
- (UIColor *)cg_setupBorderColorWithState:(CGViewBorderState)state
{
    return [self.borderDict[[self cg_keyWithState:state]] borderColor];
}

- (CGFloat)cg_setupBorderWidthWithState:(CGViewBorderState)state
{
    return [self.borderDict[[self cg_keyWithState:state]] borderWidth];
}

- (void)cg_setupViewBorder
{
    UIColor *color = [self cg_setupBorderColorWithState:self.viewBorderState];
    CGFloat  width = [self cg_setupBorderWidthWithState:self.viewBorderState];
    
    //内部设置时关闭回调
    self.borderLayer.disableSendDelegateAction  = YES;
    [self cg_setupBorderWithWidth:width color:color];
    //设置后再打开值改变时的回调
    self.borderLayer.disableSendDelegateAction  = NO;
}

#pragma mark - CGBorderLayerDelegate
- (void)cg_layerDidChangeBorderColor:(CGBorderBaseLayer *)layer
{
    [self cg_setupBorderWithLayer:layer];
}

- (void)cg_layerDidChangeBorderWidth:(CGBorderBaseLayer *)layer
{
    [self cg_setupBorderWithLayer:layer];
}

- (void)cg_setupBorderWithLayer:(CGBorderBaseLayer *)layer
{
    UIColor *borderColor            = [UIColor colorWithCGColor:layer.borderColor];
    CGFloat borderWidth             = layer.borderWidth;
    CGBorderObject *borderObject    = [CGBorderObject cg_createBorderWithColorObject:borderColor width:borderWidth];
    [self cg_setupBorderWithBorderObject:borderObject state:layer.borderState];
}

#pragma mark - 设置属性
- (CGBorderBaseLayer *)borderLayer
{
    if ([self.layer isKindOfClass:[CGBorderBaseLayer class]]) {
        return (id)self.layer;
    }
    return nil;
}

- (NSMutableDictionary *)borderDict
{
    if (_borderDict) {
        return _borderDict;
    }
    
    _borderDict = [NSMutableDictionary dictionary];
    
    return _borderDict;
}

- (void)setViewBorderState:(CGViewBorderState)viewBorderState
{
    if (_viewBorderState != viewBorderState) {
        _viewBorderState = viewBorderState;
        [self cg_setupViewBorder];
    }
}
@end
