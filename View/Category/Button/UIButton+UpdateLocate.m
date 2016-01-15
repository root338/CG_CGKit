//
//  UIButton+UpdateLocate.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/13.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIButton+UpdateLocate.h"

@implementation UIButton (UpdateLocate)

- (void)buttonContentAligeHorizonalTitle_ImageForSpace:(CGFloat)paramSpace
{
//    CGRect bounds = self.bounds;
    
    CGFloat titleLabelWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}].width;
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.bounds);
    
//    bounds.size.width = titleLabelWidth + imageViewWidth + paramSpace;
//    self.bounds = bounds;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleLabelWidth, 0, -titleLabelWidth);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageViewWidth - paramSpace, 0, imageViewWidth);
}

- (CGSize)cg_updateButtonSizeWithStyle:(CGButtonStyle)style space:(CGFloat)paramSpace
{
    [self sizeToFit];
    CGSize size = self.size;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if (style == CGButtonStyleHorizonalRight || style == CGButtonStyleHorizonalLeft) {
        
        size.width += paramSpace;
    }else {
        
        size = CGSizeMake(MAX(self.titleLabel.width, self.imageView.width), self.titleLabel.height + self.imageView.height + paramSpace);
    }
    return size;
}

- (void)cg_updateButtonWithStyle:(CGButtonStyle)style space:(CGFloat)paramSpace
{
    paramSpace /= 2.0;
    CGFloat imageViewWidth      = CGRectGetWidth(self.imageView.bounds);
    CGFloat titleLabelWidth     = CGRectGetWidth(self.titleLabel.bounds);
    
    //  按钮初始状态  | - 图片 - 标题 - |
    
    UIEdgeInsets    imageEdgeInsets;
    UIEdgeInsets    titleEdgeInsets;
    
    if (CGButtonStyleHorizonalLeft == style) {
        
        CGFloat titleLabelHorizonalSpace    = titleLabelWidth + paramSpace;
        CGFloat imageViewHorizonalSpace     = imageViewWidth + paramSpace;
        
        titleEdgeInsets = UIEdgeInsetsMake(0, -imageViewHorizonalSpace, 0, imageViewHorizonalSpace);
        imageEdgeInsets = UIEdgeInsetsMake(0, titleLabelHorizonalSpace, 0, -titleLabelHorizonalSpace);
    }else if (CGButtonStyleHorizonalRight == style) {
        
        titleEdgeInsets = UIEdgeInsetsMake(0, paramSpace, 0, -paramSpace);
        imageEdgeInsets = UIEdgeInsetsMake(0, -paramSpace, 0, paramSpace);
    }else if (CGButtonStyleVerticalTop == style || CGButtonStyleVerticalBottom == style) {
        
        CGFloat imageViewHeight         = CGRectGetHeight(self.imageView.bounds);
        CGFloat titleLabelHeight        = CGRectGetHeight(self.titleLabel.bounds);
        
        CGFloat titleLabelVerticalSpace = titleLabelHeight / 2.0 + paramSpace;
        CGFloat imageViewVerticalSpace  = imageViewHeight / 2.0 + paramSpace;
        
        CGFloat buttonCenterX           = CGRectGetMidX(self.bounds);
        CGFloat imageViewCenterX        = CGRectGetMidX(self.imageView.frame);
        CGFloat titleLabelCenterX       = CGRectGetMidX(self.titleLabel.frame);
        
        CGFloat titleLabelCenterSpace   = titleLabelCenterX - buttonCenterX;
        CGFloat imageViewCenterSpace    = buttonCenterX - imageViewCenterX;
        
        if (CGButtonStyleVerticalTop == style) {
            
            titleEdgeInsets = UIEdgeInsetsMake(-imageViewVerticalSpace, -titleLabelCenterSpace, imageViewVerticalSpace, titleLabelCenterSpace);
            imageEdgeInsets = UIEdgeInsetsMake(titleLabelVerticalSpace, imageViewCenterSpace, -titleLabelVerticalSpace, imageViewCenterSpace);
        }else {
            
            titleEdgeInsets = UIEdgeInsetsMake(imageViewVerticalSpace, -titleLabelCenterSpace, -imageViewVerticalSpace, titleLabelCenterSpace);
            imageEdgeInsets = UIEdgeInsetsMake(-titleLabelVerticalSpace, imageViewCenterSpace, titleLabelVerticalSpace, imageViewCenterSpace);
        }
    }
    
    self.titleEdgeInsets    = titleEdgeInsets;
    self.imageEdgeInsets    = imageEdgeInsets;
}
@end
