//
//  CGSelectorLayerAnimation.m
//  TestCG_CGKit
//
//  Created by DY on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGSelectorLayerAnimation.h"

@implementation CGSelectorLayerAnimation

+ (nullable CAAnimation *)createLayerAnimation:(CGSelectorLayerAnimationStyle)layerAnimation
{
    CAAnimation *animation  = nil;
    switch (layerAnimation) {
        case CGSelectorLayerAnimationStyleScaleForShow:
            animation   = [self createLayerForAlertViewAnimationsScaleForShow];
            break;
        case CGSelectorLayerAnimationStyleAlpha:
            
            break;
        default:
            break;
    }
    return animation;
}

//防UIAlertView的弹出效果
+ (CAAnimation *)createLayerForAlertViewAnimationsScaleForShow
{
    CAKeyframeAnimation *scale  = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSArray *values = @[
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                        [NSValue valueWithCATransform3D:CATransform3DIdentity],
                        ];
    scale.values    = values;
    scale.keyTimes  = @[@0.0f, @0.5f, @0.75f, @1.0f];
    CAMediaTimingFunction *easeInEaseOut    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.timingFunctions   = @[
                                easeInEaseOut,
                                easeInEaseOut,
                                easeInEaseOut,
                                ];
    scale.duration  = 0.4;
    
    return scale;
}

+ (CABasicAnimation *)createAnimationWithKeyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue
{
    CABasicAnimation *basicAnimation    = [CABasicAnimation animationWithKeyPath:keyPath];
    basicAnimation.fromValue            = fromValue;
    basicAnimation.toValue              = toValue;
    return basicAnimation;
}

@end
