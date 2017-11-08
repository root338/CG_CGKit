//
//  CGMultilineLabel.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGMultilineLabel.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGCreate.h"

@implementation CGMultilineLabel

+ (instancetype)cg_createZeroLinesLabel
{
    return [self cg_createLabelWithNumberOfLines:0];
}

+ (instancetype)cg_createLabelWithNumberOfLines:(NSUInteger)numberOfLines
{
    CGMultilineLabel *label = [self cg_createView];
    label.numberOfLines = numberOfLines;
    return label;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.preferredMaxLayoutWidth = CGRectGetWidth(bounds);
}

@end
