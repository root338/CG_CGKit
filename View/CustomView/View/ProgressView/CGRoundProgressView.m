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

typedef NS_ENUM(NSInteger, _CGProgressLayerType) {
    
    _CGProgressLayerTypeProgress,
    _CGProgressLayerTypeTrack,
};

@interface CGRoundProgressView ()
{
    
}

@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *trackLayer;

/// 窗口是隐藏状态
//@property (nonatomic, assign) BOOL windowsIsHidden;
@end

@implementation CGRoundProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _progressTintColor      = [UIColor whiteColor];
        self.backgroundColor    = [UIColor blackColor];
        _radius                 = 30;
        _lineWidth              = 3;
//        _windowsIsHidden        = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        [self layoutProgressLayer];
    }else {
        [self clearProgressLayer];
    }
}

//- (void)willMoveToWindow:(UIWindow *)newWindow
//{
//    [super willMoveToWindow:newWindow];
//    self.windowsIsHidden    = newWindow == nil ? YES : NO;
//}

- (void)clearProgressLayer
{
    [_progressLayer removeFromSuperlayer];
    _progressLayer  = nil;
}

- (void)layoutProgressLayer
{
    CALayer *layer  = self.progressLayer;
    [self.layer addSublayer:layer];
    
    CGFloat widthDiff = CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds);
    CGFloat heightDiff = CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds);
    layer.position = CGPointMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(layer.bounds) / 2 - widthDiff / 2, CGRectGetHeight(self.bounds) - CGRectGetHeight(layer.bounds) / 2 - heightDiff / 2);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake((self.radius + self.lineWidth / 2.0 + 5) * 2, (self.radius + self.lineWidth / 2.0 + 5) * 2);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.superview) {
        [self layoutProgressLayer];
    }
}

- (CAShapeLayer *)createLayerWithLayerType:(_CGProgressLayerType)layerType
{
    
    CGPoint arcCenter   = CGPointMake(self.radius + self.lineWidth / 2 + 5, self.radius + self.lineWidth);
    UIBezierPath *arcBezierPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:self.radius startAngle:(CGFloat)-M_PI_2 endAngle:(CGFloat) (M_PI_2 + M_PI) clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.frame         = CGRectMake(0, 0, arcCenter.x * 2, arcCenter.y * 2);
    shapeLayer.contentsScale = [UIScreen mainScreen].scale;
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    
    UIColor *strokeColor     = nil;
    switch (layerType) {
        case _CGProgressLayerTypeProgress:
            strokeColor = self.progressTintColor;
            break;
        case _CGProgressLayerTypeTrack:
            strokeColor = self.trackTintColor;
            break;
        default:
            
            break;
    }
    shapeLayer.strokeColor   = strokeColor.CGColor;
    shapeLayer.lineWidth     = self.lineWidth;
    shapeLayer.lineCap       = kCALineCapRound;
    shapeLayer.lineJoin      = kCALineJoinRound;
    shapeLayer.path          = arcBezierPath.CGPath;
    
    return shapeLayer;
}

- (CAShapeLayer *)progressLayer
{
    if (_progressLayer == nil) {
        
        _progressLayer              = [self createLayerWithLayerType:_CGProgressLayerTypeProgress];
        _progressLayer.strokeStart      = 0.0;
        _progressLayer.strokeEnd        = _progress;
    }
    
    return _progressLayer;
}

- (CAShapeLayer *)trackLayer
{
    if (_trackLayer == nil) {
        
        _trackLayer = [self createLayerWithLayerType:_CGProgressLayerTypeTrack];
        _trackLayer.strokeStart = 0.0;
        _trackLayer.strokeEnd   = 1.0;
    }
    
    return _trackLayer;
}

- (void)setProgress:(CGFloat)progress
{
    _progress   = progress;
    _progressLayer.strokeEnd = progress;
}

- (void)setRadius:(CGFloat)radius
{
    if (_radius != radius) {
        _radius = radius;
        
        [self clearProgressLayer];
        if (self.superview) {
            [self layoutProgressLayer];
        }
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth  = lineWidth;
    _progressLayer.lineWidth    = lineWidth;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor          = progressTintColor;
    _progressLayer.strokeColor  = progressTintColor.CGColor;
}
@end
