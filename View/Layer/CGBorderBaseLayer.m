//
//  CGBorderButtonLayer.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBorderBaseLayer.h"

//协议
#import "CGViewBorderStateProtocol.h"

//辅助类
#import "CGBorderObject.h"

@interface CGBorderBaseLayer ()<CGViewBorderStateProtocol>

@property (nonatomic, strong) NSMutableDictionary<NSNumber*, CGBorderObject *> *borderDict;
@end

@implementation CGBorderBaseLayer

- (void)setBorderColor:(CGColorRef)borderColor
{
    if (borderColor == self.borderColor) {
        return;
    }
    
    [self cg_updateBorderColor:[UIColor colorWithCGColor:borderColor]
                          state:CGViewBorderStateNormal];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (borderWidth == self.borderWidth) {
        return;
    }
    [self cg_updateBorderWidth:borderWidth
                         state:CGViewBorderStateNormal];
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

- (void)cg_updateBorderColor:(UIColor *)color state:(CGViewBorderState)state
{
    NSNumber *key = [self cg_keyWithState:state];
    
    if (self.borderDict[key]) {
        
        [self.borderDict[key] setBorderColor:color];
    }
}

- (void)cg_updateBorderWidth:(CGFloat)width state:(CGViewBorderState)state
{
    NSNumber *key = [self cg_keyWithState:state];
    if (self.borderDict[key]) {
        
        [self.borderDict[key] setBorderWidth:width];
    }else {
        
    }
}

- (BOOL)cg_updateFaildIsCreateBorderObjectWithState:(CGViewBorderState)state
{
    return YES;
}

- (void)cg_setupViewBorderWithColor:(UIColor *)color width:(CGFloat)width state:(CGViewBorderState)state
{
    UIColor *color = [self cg_setupBorderColorWithState:self.viewBorderState];
    CGFloat  width = [self cg_setupBorderWidthWithState:self.viewBorderState];
    
    //内部设置时关闭回调
//    self.borderLayer.disableSendDelegateAction  = YES;
    super.borderColor    = color.CGColor;
    super.borderWidth    = width;
    //设置后再打开值改变时的回调
//    self.borderLayer.disableSendDelegateAction  = NO;
}

- (void)cg_applyBorder
{
    
}

#pragma mark - 设置属性
- (NSMutableDictionary *)borderDict
{
    if (_borderDict) {
        return _borderDict;
    }
    
    _borderDict = [NSMutableDictionary dictionary];
    
    return _borderDict;
}

@end
