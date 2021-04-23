//
//  CGBorderButtonLayer.m
//  TestCG_CGKit
//
//  Created by DY on 15/12/10.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBorderBaseLayer.h"

#import "CGBorderObject.h"

@interface CGBorderBaseLayer ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber*, CGBorderObject *> *borderDict;
@end

@implementation CGBorderBaseLayer

#pragma mark - 重新系统方法
- (void)setBorderColor:(CGColorRef)borderColor {
    if (borderColor == self.borderColor) return;
    [self _getBorderModelWithState:CGViewBorderStateNormal isNullCreate:YES]
    .borderColor = [UIColor colorWithCGColor:borderColor];
    [self cg_updateBorder];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth == self.borderWidth) return;
    [self _getBorderModelWithState:CGViewBorderStateNormal isNullCreate:YES].borderWidth = borderWidth;
    [self cg_updateBorder];
}

#pragma mark - 状态值转换、保存
- (CGBorderObject *)borderObjectForState:(CGViewBorderState)state {
    return _borderDict[@(state)];
}

/** 保存输入参数颜色（UIColor）、宽度（CGFloat） */
- (void)cg_setupBorderWithColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth state:(CGViewBorderState)state {
    self.borderDict[@(state)] = [CGBorderObject cg_createBorderWithColorObject:borderColor width:borderWidth];
    [self cg_updateBorder];
}

- (void)cg_setupBorderWithBorderObject:(CGBorderObject *)borderObject state:(CGViewBorderState)state {
    self.borderDict[@(state)] = borderObject;
    [self cg_updateBorder];
}

- (void)cg_updateBorder {
    if (_borderDict == nil) return;
    CGBorderObject *borderObject = [self borderObjectForState:self.borderState]?: [self borderObjectForState:CGViewBorderStateNormal];
    if (borderObject != nil) {
        super.borderColor = [borderObject.borderColor CGColor];
        super.borderWidth = borderObject.borderWidth;
    }
}

- (CGBorderObject *)_getBorderModelWithState:(CGViewBorderState)state isNullCreate:(BOOL)isNullCreate {
    NSNumber *key = @(state);
    CGBorderObject *borderObject = _borderDict[key];
    if (borderObject == nil && isNullCreate) {
        borderObject = CGBorderObject.new;
        self.borderDict[key] = borderObject;
    }
    return borderObject;
}

#pragma mark - 设置属性
- (NSMutableDictionary *)borderDict {
    if (_borderDict == nil) {
        _borderDict = [NSMutableDictionary dictionary];
    }
    return _borderDict;
}

- (void)setBorderState:(CGViewBorderState)borderState {
    if (borderState != _borderState) {
        _borderState = borderState;
        [self cg_updateBorder];
    }
}

@end
