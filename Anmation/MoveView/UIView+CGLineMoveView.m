//
//  UIView+CGMoveView.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGLineMoveView.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGSetupAnimationArea.h"

@implementation UIView (CGLineMoveView)

#pragma mark - 显示视图
- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type
{
    [self cg_showLineMoveWithOverlayView:overlayView type:type completion:nil];
}

- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type completion:(void (^)(void))completion
{
    [self cg_showLineMoveWithOverlayView:overlayView type:type animation:YES completion:completion];
}

- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation completion:(void (^)(void))completion
{
    [self cg_showLineMoveWithOverlayView:overlayView type:type animation:animation duration:1/3.0 completion:completion];
}

- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    [self cg_showLineMoveWithOverlayView:overlayView type:type animation:animation duration:duration beforeAnimationBlock:nil afterAnimationBlock:nil completion:completion];
}

- (void)cg_showLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion
{
    CGPoint startPoint  = CGPointZero;
    CGPoint endPoint    = CGPointZero;
    
    [self cg_setupLineMovePointWithOverlayView:overlayView startPoint:&startPoint endPoint:&endPoint type:type isShow:YES];
    
    if (animation) {
        
        self.origin = startPoint;
        if (beforeAnimationBlock) {
            beforeAnimationBlock(self);
        }
        [UIView animateWithDuration:duration animations:^{
            
            self.origin = endPoint;
            if (afterAnimationBlock) {
                afterAnimationBlock(self);
            }
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }else {
        
        self.origin = endPoint;
        if (afterAnimationBlock) {
            afterAnimationBlock(self);
        }
    }
}

#pragma mark - 隐藏视图
- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type
{
    [self cg_dismissLineMoveWithOverlayView:overlayView type:type completion:nil];
}

- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type completion:(void (^)(void))completion
{
    [self cg_dismissLineMoveWithOverlayView:overlayView type:type animation:YES completion:completion];
}

- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation completion:(void (^)(void))completion
{
    [self cg_dismissLineMoveWithOverlayView:overlayView type:type animation:animation duration:1/3.0 completion:completion];
}

- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    [self cg_dismissLineMoveWithOverlayView:overlayView type:type animation:animation duration:duration beforeAnimationBlock:nil afterAnimationBlock:nil completion:completion];
}

- (void)cg_dismissLineMoveWithOverlayView:(UIView *)overlayView type:(CGLineMoveViewType)type animation:(BOOL)animation duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion
{
    CGPoint endPoint    = CGPointZero;
    
    [self cg_setupLineMovePointWithOverlayView:overlayView startPoint:nil endPoint:&endPoint type:type isShow:NO];
    
    if (animation) {
        
        if (beforeAnimationBlock) {
            beforeAnimationBlock(self);
        }
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.origin = endPoint;
            if (afterAnimationBlock) {
                afterAnimationBlock(self);
            }
        } completion:^(BOOL finished) {
            
            if (completion) {
                completion();
            }
        }];
        
    }else {
        
        self.origin = endPoint;
        if (afterAnimationBlock) {
            afterAnimationBlock(self);
        }
    }
}

@end
