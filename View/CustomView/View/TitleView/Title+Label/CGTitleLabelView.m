//
//  CGTitleLabelView.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTitleLabelView.h"

#import "UILabel+CGCreateCustomLabel.h"
#import "UILabel+CalculateTextSize.h"
#import "UIView+CG_CGAreaCalculate.h"
#import "UIView+CGAnimated.h"

#import "CGPrintLogHeader.h"

@interface CGTitleLabelView ()

@property (strong, nonatomic, readwrite) CGMultilineLabel *titleLabel;

@end

@implementation CGTitleLabelView

- (void)initialization
{
    [super initialization];
    self.singleTitleView            = self.titleLabel;
    self.clipsToBounds              = YES;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.titleLabel.superview ?: [self addSubview:self.titleLabel];
    }
}

#pragma mark - 布局设置
- (CGFloat)calcelateTitleViewSize
{
    return [self calcelateTitleViewSizeWithAnimated:NO];
}

- (CGFloat)calcelateTitleViewSizeWithAnimated:(BOOL)isAnimated
{
    return [self calcelateTitleViewSizeWithAnimated:isAnimated autoUpdateBounds:self.isAutoUpdateTitleLabelBounds];
}

- (CGFloat)calcelateTitleViewSizeWithAnimated:(BOOL)isAnimated autoUpdateBounds:(BOOL)isAutoUpdate
{
    CGFloat textHeight  = 0;
    
    CGFloat maxWidth    = CG_CGWidthWithMaxWidth(self.width, self.marginEdgeInsets);
    
    CGSize sizeFotTitleLabel = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth, FLT_MAX)];
    
    textHeight = CG_CGMaxHeightWithHeight(sizeFotTitleLabel.height, self.marginEdgeInsets);
    
    if (isAutoUpdate) {
        if (sizeFotTitleLabel.height <= CG_CGHeightWithMaxHeight(self.height, self.marginEdgeInsets)) {
            
            self.titleLabel.frame = CG_CGRectWithMargin(self.bounds, self.marginEdgeInsets);
        }else {
            
            self.titleLabel.frame = CGRectMake(self.marginEdgeInsets.left, self.marginEdgeInsets.top, maxWidth, sizeFotTitleLabel.height);
            
            [self changeStatusWithIsAnimated:isAnimated animations:^{
                
                CGRect frame = CG_CGMaxBoundsWithRectMargin(self.titleLabel.frame, self.marginEdgeInsets);
                frame.origin = self.origin;
                self.frame = frame;
            }];
            
            CGInfoLog(@"更新父视图坐标:%@",NSStringFromCGRect(self.frame));
        }
    }
    
    CGInfoLog(@"计算的文本最适合的大小为:%@", NSStringFromCGSize(sizeFotTitleLabel));
    
    return textHeight;
}

- (void)dealloc
{
    CGInfoLog(@"已释放");
}

#pragma mark - 属性设置
- (CGMultilineLabel *)titleLabel
{
    if (_titleLabel) {
        return _titleLabel;
    }
    
    _titleLabel = [CGMultilineLabel cg_createDefaultLabel];
    
    return _titleLabel;
}

@end
