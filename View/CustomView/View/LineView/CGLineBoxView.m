//
//  CGLineBoxView.m
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGLineBoxView.h"
#import "UIColor+ColorValueTransform.h"
#import "UIView+CGSetupFrame.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation CGLineBoxView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self awakeFromNib];
        _rectCorner = UIRectCornerAllCorners;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _lineWidth = .5;
    _lineColor = __K_CG_16_VALUE_COLOR(KCG_16_ColorValueType_0XE5E5E5);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
//    //当线宽为奇数时偏移绘制坐标
//    CGFloat pixelAdjustOffset;
//    if ((int)(self.lineWidth * [UIScreen mainScreen].scale) % 2 != 0) {
//        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
//    }
//    
//    CGRect roundedRect = self.bounds;
//    roundedRect.origin.x -= pixelAdjustOffset;
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:self.rectCorner cornerRadii:self.cornerRadii];
//    
//    [self.lineColor setStroke];
//    [bezierPath stroke];
    
    if (self.rectCorner != 0 && self.lineColor && self.lineWidth > 0.001) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        if (self.rectCorner & LineBoxTypeTop) {
            CGPathMoveToPoint(path, NULL, 0, 0);
            CGPathAddLineToPoint(path, NULL, self.width, 0);
        }
        
        if (self.rectCorner & LineBoxTypeRight) {
            CGFloat originX = self.width - self.lineWidth;
            CGPathMoveToPoint(path, NULL, originX, 0);
            CGPathAddLineToPoint(path, NULL, originX, self.height);
        }
        
        if (self.rectCorner & LineBoxTypeBottom) {
            CGFloat originY = self.height - self.lineWidth;
            CGPathMoveToPoint(path, NULL, self.width, originY);
            CGPathAddLineToPoint(path, NULL, 0, originY);
        }
        
        if (self.rectCorner & LineBoxTypeLeft) {
            CGPathMoveToPoint(path, NULL, 0, self.height);
            CGPathAddLineToPoint(path, NULL, 0, 0);
        }
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        bezierPath.CGPath = path;
        
        [self.lineColor setStroke];
        bezierPath.lineWidth = self.lineWidth;
        [bezierPath stroke];
        
        CGPathRelease(path);
    }
}

#pragma mark 设置属性
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    
    [self setNeedsDisplay];
}

- (void)setRectCorner:(LineBoxType)rectCorner
{
    _rectCorner = rectCorner;
    
    [self setNeedsDisplay];
}

- (void)setCornerRadii:(CGSize)cornerRadii
{
    _cornerRadii = cornerRadii;
    
    [self setNeedsDisplay];
}

@end
