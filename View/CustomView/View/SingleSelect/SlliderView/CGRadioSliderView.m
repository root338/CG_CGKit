//
//  CGRadioSliderView.m
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioSliderView.h"

@implementation CGRadioSliderView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_backgroundGradientLayout) {
        (_backgroundGradientLayout.superlayer == self.layer)?: [self.layer addSublayer:_backgroundGradientLayout];
        if (!CGRectEqualToRect(_backgroundGradientLayout.frame, self.bounds)) {
            _backgroundGradientLayout.frame = self.bounds;
        }
    }
}

@end
