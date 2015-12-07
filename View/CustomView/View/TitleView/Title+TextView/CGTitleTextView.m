//
//  CGTitleTextView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGTitleTextView.h"

#import "UILabel+CGCreateCustomLabel.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UILabel+CalculateTextSize.h"
#import "UITextView+CGCalculateTextSize.h"
#import "UIView+CGSetupFrame.h"
#import "CGViewConstantValue.h"

#import "CGPrintLogHeader.h"

@interface CGTitleTextView ()<UITextViewDelegate>

@property (strong, nonatomic, readwrite) CGMultilineLabel *titleLabel;
@property (strong, nonatomic, readwrite) CGInputTextView  *textView;

@end

@implementation CGTitleTextView

#pragma mark - 重置布局
- (CGFloat)updateSubviewsLayout
{
    CGFloat maxWidth        = CG_CGWidthWithMaxWidth(self.width, self.marginEdgeInsets);
    CGSize titleSize        = [self.titleLabel calculateLabelSizeWithMaxWidth:maxWidth];
    
    CGRect titleLabelFrame  = CG_CGRectWithExcludeBottom(self.bounds, self.marginEdgeInsets, titleSize.height);
    if (!CGRectEqualToRect(self.titleLabel.frame, titleLabelFrame) && !self.disableAutoSetupSubviewsFrame) {
        
        self.titleLabel.frame   = titleLabelFrame;
    }
    
    CGSize textSize         = [self.textView sizeThatFits:CGSizeMake(self.textView.width, FLT_MAX)];
    
    CGFloat textMinHeight   = self.textViewMinHeight;
    if (textSize.height < textMinHeight) {
        textSize.height = textMinHeight;
    }
    
    CGRect textViewFrame    = CG_CGRectWithExcludeVertical(self.bounds, self.marginEdgeInsets, self.titleLabel.maxY + self.spaceSubviews, textSize.height);
    if (!CGRectEqualToRect(self.textView.frame, textViewFrame) && !self.disableAutoSetupSubviewsFrame) {
        
        self.textView.frame     = textViewFrame;
        [self.textView scrollRangeToVisible:NSMakeRange(0, self.textView.text.length)];
        
        CGInfoLog(@"text view:%@, calculate frmae: %@, ", self.textView, NSStringFromCGRect(textViewFrame));

    }
    
    CGFloat didUpdateHeight = CGRectGetMaxY(textViewFrame) + self.marginEdgeInsets.bottom;
    return didUpdateHeight;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.titleLabel.superview   ?: [self addSubview:self.titleLabel];
        self.textView.superview     ?: [self addSubview:self.textView];
        
        [self setupNormalBackground];
    }
}

- (void)setupTextViewDelegate
{
    if (self.textViewEditBackgroundColor || self.textViewNormalBackgroundColor) {
        self.textView.delegate = self;
    }
}

- (void)setupEditingBackground
{
    if (self.textViewEditBackgroundColor && self.textView.backgroundColor != self.textViewEditBackgroundColor) {
        self.textView.backgroundColor = self.textViewEditBackgroundColor;
    }
}

- (void)setupNormalBackground
{
    if (self.textViewNormalBackgroundColor && self.textView.backgroundColor != self.textViewNormalBackgroundColor) {
        self.textView.backgroundColor = self.textViewNormalBackgroundColor;
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self setupEditingBackground];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self setupNormalBackground];
}

#pragma mark - 创建属性
- (CGMultilineLabel *)titleLabel
{
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [CGMultilineLabel cg_createZeroLinesLabel];
    return _titleLabel;
}

- (CGInputTextView *)textView
{
    if (_textView) {
        return _textView;
    }
    
    _textView = [[CGInputTextView alloc] init];
    return _textView;
}

- (void)setTextViewEditBackgroundColor:(UIColor *)textViewEditBackgroundColor
{
    if (_textViewEditBackgroundColor != textViewEditBackgroundColor) {
        
        _textViewEditBackgroundColor = textViewEditBackgroundColor;
        [self setupTextViewDelegate];
    }
}

- (void)setTextViewNormalBackgroundColor:(UIColor *)textViewNormalBackgroundColor
{
    if (_textViewNormalBackgroundColor != textViewNormalBackgroundColor) {
        
        _textViewNormalBackgroundColor = textViewNormalBackgroundColor;
        [self setupTextViewDelegate];
    }
}

@end
