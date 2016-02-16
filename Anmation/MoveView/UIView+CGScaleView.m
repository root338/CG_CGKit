//
//  UIView+CGScaleView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGScaleView.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CGSetupAnimationArea.h"

@implementation UIView (CGScaleView)

#pragma mark - 缩放显示视图
- (void)cg_showScaleWithType:(CGScaleViewType)type
{
    [self cg_showScaleWithType:type completion:nil];
}

- (void)cg_showScaleWithType:(CGScaleViewType)type completion:(void (^)(void))completion
{
    [self cg_showScaleWithType:type duration:1/3.0 completion:completion];
}

- (void)cg_showScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    [self cg_showScaleWithType:type duration:duration beforeAnimationBlock:nil afterAnimationBlock:nil completion:completion];
}

- (void)cg_showScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion
{
    CGPoint startPoint  = CGPointZero;
    
    CGRect  tempFrame    = self.frame;
    
    [self cg_setupScaleWithVertexPoint:&startPoint type:type];
        
    self.frame = (CGRect){startPoint, CGSizeZero};
    if (beforeAnimationBlock) {
        beforeAnimationBlock(self);
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.frame = tempFrame;
        if (afterAnimationBlock) {
            afterAnimationBlock(self);
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - 缩放隐藏视图
- (void)cg_dismissScaleWithType:(CGScaleViewType)type
{
    [self cg_dismissScaleWithType:type completion:nil];
}

- (void)cg_dismissScaleWithType:(CGScaleViewType)type completion:(void (^)(void))completion
{
    [self cg_dismissScaleWithType:type duration:1/3.0 completion:completion];
}

- (void)cg_dismissScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration completion:(void(^)(void))completion
{
    [self cg_dismissScaleWithType:type duration:duration beforeAnimationBlock:nil afterAnimationBlock:nil completion:completion];
}

- (void)cg_dismissScaleWithType:(CGScaleViewType)type duration:(NSTimeInterval)duration beforeAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))beforeAnimationBlock afterAnimationBlock:(void (^ _Nullable)(UIView * _Nonnull))afterAnimationBlock completion:(nonnull void (^)(void))completion
{
    CGPoint endPoint    = CGPointZero;
    
    [self cg_setupScaleWithVertexPoint:&endPoint type:type];
    
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
