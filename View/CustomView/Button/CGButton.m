//
//  CGButton.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGButton.h"

#import "UIView+CGSetupFrame.h"
#import "UIButton+UpdateLocate.h"
#import "UIView+CG_CGAreaCalculate.h"

#import "NSObject+CGDelaySelector.h"

#import "CGPrintLogHeader.h"

@interface CGButton ()
{
    CGRect _titleRect;
    CGRect _imageRect;
}

@end

@implementation CGButton

- (void)initialization
{
    [super initialization];
    
    [self cg_performAfterZeroDelaySelector:@selector(cg_updateButtonLayout)];
}

#pragma mark - 重置按钮布局
/** 计算按钮最适合大小 */
- (CGSize)cg_calculateButtonSize
{
    CGSize size = [self cg_calculateButtonSizeWithStyle:self.buttonStyle space:self.space];
    size        = CG_CGMaxSizeWidthSize(size, self.marginEdgeInsets);
    
    if (!CGSizeEqualToSize(self.maxSize, CGSizeZero)) {
        size = CG_CGMinSize(size, self.maxSize);
    }
    return size;
}

- (CGRect)cg_calculateContentRect
{
    CGRect contentRect = UIEdgeInsetsInsetRect(self.bounds, self.marginEdgeInsets);
    return contentRect;
}

- (void)cg_updateButtonLayout
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(cg_updateButtonLayout)
                                               object:nil];
    
    self.size   = [self cg_calculateButtonSize];
    
    CGSize tempContentSize  = [self cg_calculateContentRect].size;
    CGSize tempImageSize    = self.imageView.image.size;
    CGSize tempTitleSize    = [self.titleLabel sizeThatFits:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    _titleRect.size         = tempTitleSize;
    _imageRect.size         = tempImageSize;
    
    if (CGButtonStyleHorizonalLeft == self.buttonStyle || CGButtonStyleHorizonalRight == self.buttonStyle) {
        
        CGFloat tempTitleY  = (tempContentSize.height - tempTitleSize.height) / 2.0;
        CGFloat tempImageY  = (tempContentSize.height - tempImageSize.height) / 2.0;
        
        if (CGButtonStyleHorizonalLeft == self.buttonStyle) {
            _titleRect.origin   = CGPointMake(0, tempTitleY);
            _imageRect.origin   = CGPointMake(CGRectGetMaxX(_titleRect) + self.space, tempImageY);
        }else if (CGButtonStyleHorizonalRight == self.buttonStyle) {
            _imageRect.origin   = CGPointMake(0, tempImageY);
            _titleRect.origin   = CGPointMake(CGRectGetMaxX(_imageRect) + self.space, tempTitleY);
        }
    }
    
    if (CGButtonStyleVerticalTop == self.buttonStyle || CGButtonStyleVerticalBottom == self.buttonStyle) {
        
        CGFloat tempTitleX  = (tempContentSize.width - tempTitleSize.width) / 2.0;
        CGFloat tempImageX  = (tempContentSize.width - tempImageSize.width) / 2.0;
        
        if (CGButtonStyleVerticalTop == self.buttonStyle) {
            _titleRect.origin   = CGPointMake(tempTitleX, 0);
            _imageRect.origin   = CGPointMake(tempImageX, CGRectGetMaxY(_titleRect) + self.space);
        }else if (CGButtonStyleVerticalBottom == self.buttonStyle) {
            _imageRect.origin   = CGPointMake(tempImageX, 0);
            _titleRect.origin   = CGPointMake(tempTitleX, CGRectGetMaxY(_imageRect) + self.space);
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - 重写系统布局方法
- (CGRect)contentRectForBounds:(CGRect)bounds
{
    return [self cg_calculateContentRect];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize unavailableArea  = self.imageView.image.size;
    if (self.buttonStyle == CGButtonStyleHorizonalRight || self.buttonStyle == CGButtonStyleHorizonalLeft) {
        unavailableArea.width   += self.space;
    }else {
        unavailableArea.height  += self.space;
    }
    
    CGSize tempSize     = CGSizeMake(CGRectGetWidth(contentRect) - unavailableArea.width , CGRectGetHeight(contentRect) - unavailableArea.height);
    CGSize titleSize = [self.titleLabel sizeThatFits:tempSize];
    
    
    return _titleRect;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return _imageRect;
}

#pragma mark - 属性设置
- (void)setButtonStyle:(CGButtonStyle)buttonStyle
{
    if (buttonStyle != _buttonStyle) {
        _buttonStyle = buttonStyle;
        [self cg_performAfterZeroDelaySelector:@selector(cg_updateButtonLayout)];
    }
}

- (void)setSpace:(CGFloat)space
{
    if (space != _space) {
        _space = space;
        [self cg_performAfterZeroDelaySelector:@selector(cg_updateButtonLayout)];
    }
}

- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsets, _marginEdgeInsets)) {
        _marginEdgeInsets = marginEdgeInsets;
        [self cg_performAfterZeroDelaySelector:@selector(cg_updateButtonLayout)];
    }
}

@end
