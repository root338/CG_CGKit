//
//  CGLayoutTypeTransform.h
//  QuickAskCommunity
//
//  Created by DY on 2017/6/28.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGLayoutConstraintsTypeHeader.h"

@interface CGLayoutTypeTransform : NSObject

+ (CGFloat)offsetWithInsets:(UIEdgeInsets)insets edge:(CGLayoutEdge)edge;
+ (NSLayoutAttribute)layoutAttributeWithEdge:(CGLayoutEdge)edge;
+ (NSLayoutAttribute)layoutAttributeWithAxis:(CGAxis)axis;
+ (NSLayoutAttribute)layoutAttributeWithDimension:(CGDimension)dimension;

@end
