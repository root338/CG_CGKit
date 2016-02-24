//
//  UIView+DrawLine.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/15.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+DrawBoxLine.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIView (DrawBoxLine)

@dynamic lineColor;
@dynamic lineWidth;
@dynamic drawLineType;

- (UIBezierPath *)createBoxType:(DDrawLineType)type edge:(UIEdgeInsets)edgeInsets
{
    if (type == DDrawLineTypeNone) {
        return nil;
    }
    
    CGSize size = self.bounds.size;
    CGMutablePathRef path = CGPathCreateMutable();
    
    if (type & DDrawLineTypeTop) {
        
        CGPathMoveToPoint(path, NULL, edgeInsets.left, 0);
        CGPathAddLineToPoint(path, NULL, size.width - edgeInsets.right, 0);
    }
    
    if (type & DDrawLineTypeRight) {
        CGPathMoveToPoint(path, NULL, size.width, edgeInsets.top);
        CGPathAddLineToPoint(path, NULL, size.width, size.height - edgeInsets.bottom);
    }
    
    if (type & DDrawLineTypeBottom) {
        CGPathMoveToPoint(path, NULL, size.width - edgeInsets.right, size.height);
        CGPathAddLineToPoint(path, NULL, edgeInsets.left, size.height);
    }
    
    if (type & DDrawLineTypeLeft) {
        CGPathMoveToPoint(path, NULL, 0, size.height - edgeInsets.bottom);
        CGPathAddLineToPoint(path, NULL, 0, edgeInsets.top);
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.CGPath = path;
    
    CGPathRelease(path);
    [self.lineColor setStroke];
    
    bezierPath.lineWidth = self.lineWidth;
    return bezierPath;
}

//- (void)drawRect:(CGRect)rect
//{
//    
//}

#pragma mark - property

- (void)setLineColor:(UIColor *)paramLineColor
{
    objc_setAssociatedObject(self, @selector(lineColor), paramLineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)lineColor
{
    return objc_getAssociatedObject(self, @selector(lineColor));
}

- (void)setLineWidth:(CGFloat)paramLineWidth
{
    objc_setAssociatedObject(self, @selector(lineWidth), @(paramLineWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lineWidth
{
    return [objc_getAssociatedObject(self, @selector(lineWidth)) floatValue];
}

- (void)setDrawLineType:(DDrawLineType)lineType
{
    objc_setAssociatedObject(self, @selector(drawLineType), @(lineType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DDrawLineType)drawLineType
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
@end
