//
//  CGRoundProgressView.m
//  QuickAskCommunity
//
//  Created by DY on 2017/3/14.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "CGRoundProgressView.h"
#import "UIView+CGSetupFrame.h"
#import "CGAngleRadianHeader.h"

@interface CGRoundProgressView ()
{
    
}

@end

@implementation CGRoundProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _progress               = 45 / 360.0;
        _progressTintColor      = [UIColor whiteColor];
        self.backgroundColor    = [UIColor blackColor];
        _radius                 = 60;
        
    }
    return self;
}

- (void)drawProgress
{
    CGContextRef context    = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path   = CGPathCreateMutable();
    
    CGFloat x = self.width / 2.0;
    CGFloat y = self.height / 2.0;
    
    CGFloat startAngle = 270.0;
    CGFloat endAngle   = startAngle + self.progress * 360;
    
    CGPathAddArc(path, NULL, x, y, self.radius, _CG_RadianForAngle(startAngle), _CG_RadianForAngle(endAngle), NO);
    
    CGContextAddPath(context, path);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGPathRelease(path);
    
    [self.progressTintColor setStroke];
    
    [self.layer drawInContext:context];
    
    
}

@end
