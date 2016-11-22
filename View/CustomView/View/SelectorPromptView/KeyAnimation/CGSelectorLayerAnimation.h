//
//  CGSelectorLayerAnimation.h
//  TestCG_CGKit
//
//  Created by DY on 2016/11/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGSelectorLayerAnimationHeader.h"

@import QuartzCore;
NS_ASSUME_NONNULL_BEGIN

@interface CGSelectorLayerAnimation : NSObject

+ (nullable CAAnimation *)createLayerAnimation:(CGSelectorLayerAnimationStyle)layerAnimation;

+ (CABasicAnimation *)createAnimationWithKeyPath:(NSString *)keyPath fromValue:(id)fromValue toValue:(id)toValue;
@end

NS_ASSUME_NONNULL_END
