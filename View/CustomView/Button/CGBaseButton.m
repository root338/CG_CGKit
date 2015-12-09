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
    CGFloat _borderWidth;
}
@property (strong, nonatomic) NSMutableDictionary *borderColorDict;
@property (strong, nonatomic) NSMutableDictionary *borderWidthDict;
@end

@implementation CGBaseButton

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

- (nullable UIColor *)borderColorForState:(UIControlState)state
{
    return self.borderColorDict[@(state)];
}

- (CGFloat)borderWidthForState:(UIControlState)state
{
    return [self.borderWidthDict[@(state)] floatValue];
}

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state
{
    
    if (color) {
        [self.borderColorDict setObject:color forKey:@(state)];
    }else {
        [self.borderColorDict removeObjectForKey:@(state)];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state
{
    if (borderWidth > 0) {
        [self.borderWidthDict setObject:@(borderWidth) forKey:@(state)];
    }else {
        [self.borderWidthDict removeObjectForKey:@(state)];
    }
}

- (void)setupBorder/**ForCurrentState:(UIControlState)state*/
{
    [self cg_setupBorderWithWidth:self.currentBorderWidth color:self.currentBorderColor];
}

#pragma mark - 重写系统方法
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self setupBorder];
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setupBorder];
    
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setupBorder];
}

#pragma mark - 设置属性
- (NSMutableDictionary *)borderColorDict
{
    if (_borderColorDict) {
        return _borderColorDict;
    }
    
    _borderColorDict = [NSMutableDictionary dictionary];
    return _borderColorDict;
}

- (NSMutableDictionary *)borderWidthDict
{
    if (_borderWidthDict) {
        return _borderWidthDict;
    }
    
    _borderWidthDict = [NSMutableDictionary dictionary];
    
    return _borderWidthDict;
}

- (UIColor *)currentBorderColor
{
    NSNumber *currentState = @(self.state);
    UIColor *currentBorderColor = self.borderColorDict[currentState];
    
    if (!currentBorderColor) {
        
        if (self.isEnableBorderColorAutoChange) {
            if (self.borderSyncTitleColor) {
                
                currentBorderColor = self.currentTitleColor;
            }else {
                
                currentBorderColor = self.borderColorDict[@(UIControlStateNormal)];
            }
        }
    }
    return currentBorderColor;
}

- (CGFloat)currentBorderWidth
{
    
    NSNumber *key   = @(self.state);
    NSNumber *width = self.borderWidthDict[key];
    if (!self.borderWidthDict.count) {
        
        width = @(self.layer.borderWidth);
    }
    return width.floatValue;
}

- (void)setCurrentStatus:(CGViewInteractionStatus)currentStatus
{
    if (_currentStatus != currentStatus) {
        _currentStatus = currentStatus;
        
        if ([self.delegate respondsToSelector:@selector(cg_setupButton:didChangeInteractionStatus:)]) {
            [self.delegate cg_setupButton:self didChangeInteractionStatus:currentStatus];
        }
    }
}


@end
