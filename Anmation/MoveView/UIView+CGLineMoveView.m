//
//  UIView+CGMoveView.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGLineMoveView.h"

#import "UIView+CGSetupFrame.h"

@implementation UIView (CGLineMoveView)

- (void)cg_setupPointWithOverlayView:(UIView *)overlayView startPoint:(CGPoint *)paramStartPoint endPoint:(CGPoint *)paramEndPoint type:(CGLineMoveViewType)type isShow:(BOOL)isShow
{
    CGPoint startPoint  = CGPointZero;
    CGPoint endPoint    = CGPointZero;
    
    switch (type) {
        case CGLineMoveViewTypeTop:
        {
            startPoint  = CGPointMake(overlayView.xOrigin, overlayView.yOrigin - self.height);
            endPoint    = overlayView.origin;
        }
            break;
        case CGLineMoveViewTypeLeft:
        {
            startPoint  = CGPointMake(overlayView.xOrigin - self.width, overlayView.yOrigin);
            endPoint    = overlayView.origin;
        }
            break;
        case CGLineMoveViewTypeBottom:
        {
            startPoint  = CGPointMake(overlayView.xOrigin, overlayView.maxY);
            endPoint    = CGPointMake(overlayView.xOrigin, overlayView.maxY - self.height);
        }
            break;
        case CGLineMoveViewTypeRight:
        {
            startPoint  = CGPointMake(overlayView.maxX, overlayView.yOrigin);
            endPoint    = CGPointMake(overlayView.maxX - self.width, overlayView.yOrigin);
        }
            break;
        default:
            break;
    }
    
    if (isShow) {
        *paramStartPoint    = startPoint;
        *paramEndPoint      = endPoint;
    }else {
        *paramEndPoint      = startPoint;
    }
}

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
    CGPoint startPoint  = CGPointZero;
    CGPoint endPoint    = CGPointZero;
    
    [self cg_setupPointWithOverlayView:overlayView startPoint:&startPoint endPoint:&endPoint type:type isShow:YES];
    
    if (animation) {
        
        self.origin = startPoint;
        [UIView animateWithDuration:duration animations:^{
            
            self.origin = endPoint;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }else {
        
        self.origin = endPoint;
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
    CGPoint endPoint    = CGPointZero;
    
    [self cg_setupPointWithOverlayView:overlayView startPoint:nil endPoint:&endPoint type:type isShow:NO];
    
    if (animation) {
        
        [UIView animateWithDuration:duration animations:^{
            
            self.origin = endPoint;
        } completion:^(BOOL finished) {
            if (completion) {
                completion();
            }
        }];
    }else {
        
        self.origin = endPoint;
    }
}

@end
