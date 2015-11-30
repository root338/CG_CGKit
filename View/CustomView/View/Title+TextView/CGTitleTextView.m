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

@interface CGTitleTextView ()

@property (strong, nonatomic, readwrite) CGMultilineLabel *titleLabel;
@property (strong, nonatomic, readwrite) CGTextView  *textView;

@end

@implementation CGTitleTextView

#pragma mark - 重置布局
- (CGSize)updateSubviewsLayout
{
    CGFloat maxWidth        = CG_CGWidthWithSize(self.frame.size, self.marginEdgeInsets);
    CGSize titleSize        = [self.titleLabel calculateLabelSizeWithMaxWidth:maxWidth];
    self.titleLabel.frame   = CG_CGRectWithExcludeBottom(self.bounds, self.marginEdgeInsets, titleSize.height);
    
    CGSize textSize         = [self.textView calculateLabelSizeWithMaxWidth:maxWidth];
    self.textView.frame     = CG_CGRectWithExcludeTopBottom(self.bounds, self.marginEdgeInsets, self.titleLabel.maxY + self.spaceSubviews, textSize.height);
    
    return CGSizeMake(self.width, self.textView.maxY + self.marginEdgeInsets.bottom);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.titleLabel.superview   ?: [self addSubview:self.titleLabel];
        self.textView.superview     ?: [self addSubview:self.textView];
    }
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

- (CGTextView *)textView
{
    if (_textView) {
        return _textView;
    }
    
    _textView = [[CGTextView alloc] init];
    return _textView;
}

@end
