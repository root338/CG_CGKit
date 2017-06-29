//
//  CGLayoutTypeTransform.m
//  QuickAskCommunity
//
//  Created by DY on 2017/6/28.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "CGLayoutTypeTransform.h"

@implementation CGLayoutTypeTransform

+ (CGFloat)offsetWithInsets:(UIEdgeInsets)insets edge:(CGLayoutEdge)edge
{
    CGFloat offset = 0;
    switch (edge) {
        case CGLayoutEdgeTop:
            offset  = insets.top;
            break;
        case CGLayoutEdgeBottom:
            offset  = insets.bottom;
            break;
        case CGLayoutEdgeLeft:
        case CGLayoutEdgeLeading:
            offset  = insets.left;
            break;
        case CGLayoutEdgeRight:
        case CGLayoutEdgeTrailing:
            offset  = insets.right;
            break;
        default:
            break;
    }
    return offset;
}

+ (NSLayoutAttribute)layoutAttributeWithEdge:(CGLayoutEdge)edge
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    switch (edge) {
        case CGLayoutEdgeTop:
            attribute   = NSLayoutAttributeTop;
            break;
        case CGLayoutEdgeLeft:
            attribute   = NSLayoutAttributeLeft;
            break;
        case CGLayoutEdgeLeading:
            attribute   = NSLayoutAttributeLeading;
            break;
        case CGLayoutEdgeRight:
            attribute   = NSLayoutAttributeRight;
            break;
        case CGLayoutEdgeTrailing:
            attribute   = NSLayoutAttributeTrailing;
            break;
        case CGLayoutEdgeBottom:
            attribute   = NSLayoutAttributeBottom;
            break;
        default:
            break;
    }
    return attribute;
}

+ (NSLayoutAttribute)layoutAttributeWithAxis:(CGAxis)axis
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    
    switch (axis) {
        case CGAxisBaseline:
            attribute   = NSLayoutAttributeBaseline;
            break;
        case CGAxisVertical:
            attribute   = NSLayoutAttributeCenterX;
            break;
        case CGAxisHorizontal:
            attribute   = NSLayoutAttributeCenterY;
            break;
        default:
            break;
    }
    
    return attribute;
}

+ (NSLayoutAttribute)layoutAttributeWithDimension:(CGDimension)dimension
{
    NSLayoutAttribute attribute = NSLayoutAttributeNotAnAttribute;
    
    switch (dimension) {
        case CGDimensionWidth:
            attribute   = NSLayoutAttributeWidth;
            break;
        case CGDimensionHeight:
            attribute   = NSLayoutAttributeHeight;
            break;
        default:
            break;
    }
    
    return attribute;
}

@end
