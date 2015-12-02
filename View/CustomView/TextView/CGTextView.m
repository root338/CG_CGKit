//
//  CGTextView.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGTextView.h"
#import "CGMultilineLabel.h"

#import "UILabel+CGCreateCustomLabel.h"
#import "UILabel+CalculateTextSize.h"
#import "UIView+CGSetupFrame.h"

#import "NSObject+CGDelaySelector.h"
#import "CGPrintLogHeader.h"

@interface CGTextView ()
{
    BOOL isDidChangeNote;
}
/** 提示文本框 */
@property (strong, nonatomic) CGMultilineLabel *placeholderLabel;

@end

@implementation CGTextView

@synthesize placeholder = _placeholder;

- (void)initialization
{
    self.marginEdgeInsetsForPlaceholderView = UIEdgeInsetsMake(8, 5, 8, 5);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        if (!isDidChangeNote) {
//            CGInfoLog(@"添加UITextViewTextDidChangeNotification通知");
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
            isDidChangeNote = YES;
        }
    }else {
        
        if (isDidChangeNote) {
//            CGInfoLog(@"移除UITextViewTextDidChangeNotification通知");
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
            isDidChangeNote = NO;
        }
    }
}

- (void)handleTextDidChangeNotification:(NSNotification *)note
{
    if ([note.name isEqualToString:UITextViewTextDidChangeNotification]) {
        
        [self setupPlaceholder];
        if (self.textDidChangeCallback) {
            self.textDidChangeCallback(self.text);
        }
    }
}

- (CGRect)calculatePlaceholderLabelFrame
{
    CGFloat maxWidthForPlaceholderLabel = self.width - (self.marginEdgeInsetsForPlaceholderView.left + self.marginEdgeInsetsForPlaceholderView.right);
    
    CGRect textAreaFrame = [self.placeholderLabel calculateMultilineLabelTextSizeWithMaxWidth:maxWidthForPlaceholderLabel];
    CGRect frameForPlaceholderLabel = CGRectMake(self.marginEdgeInsetsForPlaceholderView.left, self.marginEdgeInsetsForPlaceholderView.top, maxWidthForPlaceholderLabel, textAreaFrame.origin.y + textAreaFrame.size.height);
    return frameForPlaceholderLabel;
}

- (void)setupPlaceholder
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(setupPlaceholder) object:nil];
    
    BOOL isShouldHidePlaceholder = self.text.length;
    if (!isShouldHidePlaceholder && self.attributedPlaceholder.length) {
        
        self.placeholderLabel.attributedText = self.attributedPlaceholder;
    }else if (!isShouldHidePlaceholder && self.placeholder.length){
        
        self.placeholderLabel.text  = self.placeholder;
    }else {
        
        if (_placeholderLabel.superview) {
            [_placeholderLabel removeFromSuperview];
        }
        _placeholderLabel = nil;
    }
    
    CGFloat horizontalSpace = self.marginEdgeInsetsForPlaceholderView.left + self.marginEdgeInsetsForPlaceholderView.right;
    if (_placeholderLabel && self.width > horizontalSpace) {
        
        if (!_placeholderLabel.superview) {
            [self addSubview:_placeholderLabel];
        }
        
        CGRect frameForPlaceholderLabel = [self calculatePlaceholderLabelFrame];
        
        if (!CGRectEqualToRect(frameForPlaceholderLabel, self.placeholderLabel.frame)) {
            
            self.placeholderLabel.frame = frameForPlaceholderLabel;
            if (self.adjustsPlaceholderSizeToFitSize) {
                
                CGSize sizeForTextView;
                sizeForTextView.width += self.placeholderLabel.maxX + self.marginEdgeInsetsForPlaceholderView.right;
                sizeForTextView.height += self.placeholderLabel.maxY + self.marginEdgeInsetsForPlaceholderView.bottom;
                if (!CGRectContainsRect(self.frame, CGRectMake(self.xOrigin, self.yOrigin, sizeForTextView.width, sizeForTextView.height))) {
                    
                    [self adjustsTextViewSize:sizeForTextView];
                }
            }
        }
    }else {
        
        CGErrorConditionLog(self.width <= horizontalSpace, @"文本输入框的宽度(%f)必须大于水平左右边距之后(%f)", self.width, horizontalSpace);
    }
}

- (void)adjustsTextViewSize:(CGSize)paramSize
{
    self.width  = MAX(paramSize.width, self.width);
    self.height = MAX(paramSize.height, self.height);
    
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setupPlaceholder];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setupPlaceholder];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    _placeholderLabel.font = font;
}

#pragma mark - 设置属性
- (CGMultilineLabel *)placeholderLabel
{
    if (_placeholderLabel) {
        return _placeholderLabel;
    }
    
    _placeholderLabel = [CGMultilineLabel cg_createZeroLinesLabel];
    _placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    
    /** UITextView在没有输入文本的情况下，font 属性为空 */
    _placeholderLabel.font  = [UIFont systemFontOfSize:12];
    return _placeholderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (![_placeholder isEqualToString:placeholder]) {
        
        _placeholder = placeholder;
        [self cg_performAfterZeroDelaySelector:@selector(setupPlaceholder)];
    }
}

- (NSString *)placeholder
{
    if (_attributedPlaceholder) {
        return _attributedPlaceholder.string;
    }
    
    return _placeholder;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    if (![_attributedPlaceholder isEqual:attributedPlaceholder]) {
        _attributedPlaceholder = attributedPlaceholder;
        [self cg_performAfterZeroDelaySelector:@selector(setupPlaceholder)];
    }
}

- (CGFloat)minHeight
{
    
    CGFloat _minPlaceholderHeight   = 0;
    CGFloat _minTextHeight          = 0;
    
    _minPlaceholderHeight = _placeholderLabel.maxY + self.marginEdgeInsetsForPlaceholderView.bottom;
    
    CGFloat marginSpace = self.marginEdgeInsetsForPlaceholderView.top + self.marginEdgeInsetsForPlaceholderView.bottom;
    if (!self.font) {
        self.font = [UIFont systemFontOfSize:12];
    }
    _minTextHeight = marginSpace + self.font.lineHeight;
    
    return MAX(_minPlaceholderHeight, _minTextHeight);
}

- (CGPoint)cursorPosition
{
    if (!self.selectedTextRange) {
        return CGPointZero;
    }
    return [self caretRectForPosition:self.selectedTextRange.end].origin;
}
@end
