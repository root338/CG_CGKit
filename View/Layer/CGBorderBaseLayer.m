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

- (instancetype)initWithLayer:(id)layer
{
    self = [super initWithLayer:layer];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    [self performSelector:@selector(cg_updateBorder) withObject:nil afterDelay:0];
}

#pragma mark - 重新系统方法
- (void)setBorderColor:(CGColorRef)borderColor
{
    if (borderColor == self.borderColor) {
        return;
    }
    
    [self cg_updateBorderColor:[UIColor colorWithCGColor:borderColor]
                          state:self.borderState];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (borderWidth == self.borderWidth) {
        return;
    }
    [self cg_updateBorderWidth:borderWidth
                         state:self.borderState];
}

#pragma mark - 状态值转换、保存
- (CGBorderObject *)borderObjectForState:(CGViewBorderState)state
{
    return self.borderDict[[self cg_keyWithState:state]];
}

/** 保存输入参数颜色（UIColor）、宽度（CGFloat） */
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
    return [[self borderObjectForState:state] borderColor];
}

- (CGFloat)cg_setupBorderWidthWithState:(CGViewBorderState)state
{
    return [[self borderObjectForState:state] borderWidth];
}

- (void)cg_updateBorderColor:(UIColor *)color state:(CGViewBorderState)state
{
    NSNumber *key = [self cg_keyWithState:state];
    
    if (self.borderDict[key]) {
        
        [self.borderDict[key] setBorderColor:color];
    }else {
        
        if ([self cg_updateFaildIsCreateBorderObjectWithState:state]) {
            [self cg_setupBorderWithColor:color borderWidth:0 state:state];
        }
    }
}

- (void)cg_updateBorderWidth:(CGFloat)width state:(CGViewBorderState)state
{
    NSNumber *key = [self cg_keyWithState:state];
    if (self.borderDict[key]) {
        
        [self.borderDict[key] setBorderWidth:width];
    }else {
        
        if ([self cg_updateFaildIsCreateBorderObjectWithState:state]) {
            
            [self cg_setupBorderWithColor:nil borderWidth:width state:state];
        }
    }
}

- (BOOL)cg_updateFaildIsCreateBorderObjectWithState:(CGViewBorderState)state
{
    return YES;
}

- (void)cg_updateBorder
{
    
    CGBorderObject *borderObject = [self borderObjectForState:self.borderState];
    super.borderColor    = borderObject.borderColor.CGColor;
    super.borderWidth    = borderObject.borderWidth;
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

- (void)setBorderState:(CGViewBorderState)borderState
{
    if (borderState != _borderState) {
        
        _borderState = borderState;
        [self cg_updateBorder];
    }
}

@end
