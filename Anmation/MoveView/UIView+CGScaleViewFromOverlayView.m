//
//  UIView+CGScaleViewFromOverlayView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGScaleViewFromOverlayView.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGSetupAnimationArea.h"

@implementation UIView (CGScaleViewFromOverlayView)

#pragma mark - 显示视图
- (void)cg_showScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint
{
    [self cg_showScaleWithOverlayView:overlayView type:type offsetPoint:offsetPoint completion:nil];
}

- (void)cg_showScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint completion:(void (^)(void))completion
{
    [self cg_showScaleWithOverlayView:overlayView type:type offsetPoint:offsetPoint duration:1/3.0 completion:completion];
}

- (void)cg_showScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    [self cg_showScaleWithOverlayView:overlayView type:type offsetPoint:offsetPoint duration:duration beforeAnimationBlock:nil afterAnimationBlock:nil completion:completion];
}

- (void)cg_showScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion
{
    CGPoint startPoint  = CGPointZero;
    CGSize  tempSize    = self.size;
    CGPoint originPoint = CGPointZero;
    
    [self cg_setupScaleWithOverlayView:overlayView vertexPoint:&startPoint originPoint:&originPoint type:type offsetPoint:offsetPoint];
    
    self.frame = (CGRect){startPoint, CGSizeZero};
    if (beforeAnimationBlock) {
        beforeAnimationBlock(self);
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.frame = (CGRect){originPoint, tempSize};
        if (afterAnimationBlock) {
            afterAnimationBlock(self);
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - 隐藏视图
- (void)cg_dismissScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint
{
    [self cg_dismissScaleWithOverlayView:overlayView type:type offsetPoint:offsetPoint completion:nil];
}

- (void)cg_dismissScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint completion:(void (^)(void))completion
{
    [self cg_dismissScaleWithOverlayView:overlayView type:type offsetPoint:offsetPoint duration:1/3.0 completion:completion];
}

- (void)cg_dismissScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    [self cg_dismissScaleWithOverlayView:overlayView type:type offsetPoint:offsetPoint duration:duration beforeAnimationBlock:nil afterAnimationBlock:nil completion:completion];
}

- (void)cg_dismissScaleWithOverlayView:(UIView *)overlayView type:(CGScaleViewType)type offsetPoint:(CGPoint)offsetPoint duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion
{
    CGPoint endPoint    = CGPointZero;
    
    [overlayView cg_setupScaleWithOverlayView:overlayView vertexPoint:&endPoint originPoint:nil type:type offsetPoint:offsetPoint];
    
    if (beforeAnimationBlock) {
        beforeAnimationBlock(self);
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.frame = (CGRect){endPoint, CGSizeZero};
        if (afterAnimationBlock) {
            afterAnimationBlock(self);
        }
    } completion:^(BOOL finished) {
        
        if (completion) {
            completion();
        }
    }];
}

@end
