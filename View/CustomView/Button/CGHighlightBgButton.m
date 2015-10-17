//
//  CGHighlightBgButton.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/13.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGHighlightBgButton.h"

@interface CGHighlightBgButton ()
{
    UIColor *normalColor;
    UIColor *highlightColor;
    UIColor *selectedColor;
    UIColor *disableColor;
}
@end

@implementation CGHighlightBgButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    
    [self setBackgroundColor:backgroundColor forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setupbackgroundColor:backgroundColor forState:state];
}

- (UIColor *)backgroundColorForState:(UIControlState)state
{
    return [self setupbackgroundColor:nil forState:state];
}

- (UIColor *)setupbackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    UIColor *color = nil;
    switch (state) {
        case UIControlStateNormal:
        {
            if (backgroundColor) {
                normalColor         = backgroundColor;
                super.backgroundColor = backgroundColor;
            }else {
                color               = normalColor;
            }
            
        }
            break;
        case UIControlStateHighlighted:
        {
            if (backgroundColor) {
                highlightColor      = backgroundColor;
            }else {
                color               = highlightColor ? highlightColor : normalColor;
            }
        }
            break;
        case UIControlStateDisabled:
        {
            if (backgroundColor) {
                disableColor        = backgroundColor;
            }else {
                color               = disableColor ? disableColor : normalColor;
            }
        }
            break;
        case UIControlStateSelected:
        {
            if (backgroundColor) {
                selectedColor       = backgroundColor;
            }else {
                color               = selectedColor ? selectedColor : normalColor;
            }
        }
            break;
        default:
            break;
    }
    return color;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [super setBackgroundColor:[self backgroundColorForState:self.state]];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [super setBackgroundColor:[self backgroundColorForState:self.state]];
}
@end
