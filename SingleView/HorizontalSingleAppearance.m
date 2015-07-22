//
//  HorizontalSingleAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "HorizontalSingleAppearance.h"

@implementation HorizontalSingleAppearance
@dynamic sliderHeight;

- (void)setSliderHeight:(CGFloat)sliderHeight
{
    CGSize sliderSize = self.sliderSize;
    
    sliderSize.height = sliderHeight;
    
    self.sliderSize = sliderSize;
}

- (CGFloat)sliderHeight
{
    return self.sliderSize.height;
}

@end
