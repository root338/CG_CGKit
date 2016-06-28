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
    
}
@property (strong, nonatomic) NSMutableDictionary *backgroundColorDic;

@end

@implementation CGHighlightBgButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)clearAllBackgroundColor
{
    [self.backgroundColorDic removeAllObjects];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    
    [self setBackgroundColor:backgroundColor forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    self.backgroundColorDic[@(state)] = backgroundColor;
    self.state != state ?: [super setBackgroundColor:backgroundColor];
}

- (nullable UIColor *)backgroundColorForState:(UIControlState)state
{
    UIColor *color = self.backgroundColorDic[@(state)];
    if (!color) {
        
        color = self.backgroundColorDic[@(UIControlStateNormal)];
    }
    return color;
}

- (void)cg_setupBackgroundColor
{
    [super setBackgroundColor:[self backgroundColorForState:self.state]];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self cg_setupBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self cg_setupBackgroundColor];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self cg_setupBackgroundColor];
}

#pragma mark - 设置属性

- (NSMutableDictionary *)backgroundColorDic
{
    if (_backgroundColorDic) {
        return _backgroundColorDic;
    }
    
    _backgroundColorDic = [NSMutableDictionary dictionary];
    
    return _backgroundColorDic;
}
@end
