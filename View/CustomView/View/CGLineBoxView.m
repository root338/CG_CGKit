//
//  CGLineBoxView.m
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGLineBoxView.h"

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
    _lineWidth = .5;
    _lineColor = RGB_A(0xe5e5e5);
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
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    if (self.rectCorner & LineBoxTypeTop) {
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, self.width, 0);
    }
    
    if (self.rectCorner & LineBoxTypeRight) {
        CGPathMoveToPoint(path, NULL, self.width, 0);
        CGPathAddLineToPoint(path, NULL, self.width, self.height);
    }
    
    if (self.rectCorner & LineBoxTypeBottom) {
        CGPathMoveToPoint(path, NULL, self.width, self.height);
        CGPathAddLineToPoint(path, NULL, 0, self.height);
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
