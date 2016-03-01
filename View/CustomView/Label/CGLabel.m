//
//  CGLabel.m
//  QuickAskCommunity
//
//  Created by DY on 16/2/26.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGLabel.h"
#import "UIView+CG_CGAreaCalculate.h"

@implementation CGLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    self.marginEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect rect = UIEdgeInsetsInsetRect(bounds, self.marginEdgeInsets);
    
    return rect;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);//MAX(0, bounds.size.width - (self.marginEdgeInsets.left + self.marginEdgeInsets.right));
}


- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:UIEdgeInsetsInsetRect(self.bounds, self.marginEdgeInsets)];
}

@end
