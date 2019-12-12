//
//  CGLineBoxView.m
//  Test_ProjectMode
//
//  Created by ym on 15/7/2.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGLineBoxView.h"

#import "UIView+Constant.h"
#import "UIColor+ColorValueTransform.h"

#import "UIView+CGSetupFrame.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@interface CGLineBoxView ()

@end

@implementation CGLineBoxView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
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
    
    if (self.rectCorner != 0 && self.lineColor && self.lineWidth > CGZeroFloatValue) {
        
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

- (void)setupLineType:(LineBoxType)lineType color:(UIColor *)lineColor length:(CGFloat)length
{
    self.rectCorner = lineType;
    self.lineColor  = lineColor;
    self.lineWidth  = length;
}

- (UIEdgeInsets)boxLineInsets
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    CGFloat lineWidth   = self.lineWidth;
    if (lineWidth < CGZeroFloatValue || self.rectCorner == 0) {
        return insets;
    }
    if (self.rectCorner &LineBoxTypeTop) {
        insets.top  = lineWidth;
    }
    if (self.rectCorner & LineBoxTypeLeft) {
        insets.left = lineWidth;
    }
    if (self.rectCorner & LineBoxTypeBottom) {
        insets.bottom   = lineWidth;
    }
    if (self.rectCorner & LineBoxTypeRight) {
        insets.right    = lineWidth;
    }
    return insets;
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

@implementation CGLineBoxView (CGCreateLineView)

+ (CGLineBoxView *)createLineViewWithLineType:(LineBoxType)type color:(UIColor *)lineColor length:(CGFloat)length
{
    CGLineBoxView *lineBoxView  = [[self alloc] init];
    [lineBoxView setupLineType:type color:lineColor length:length];
    return lineBoxView;
}

@end
