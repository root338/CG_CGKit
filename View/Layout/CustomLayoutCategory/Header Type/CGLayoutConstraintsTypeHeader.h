//
//  CGLayoutConstraintsTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGLayoutConstraintsTypeHeader_h
#define CGLayoutConstraintsTypeHeader_h

typedef /**NS_OPTIONS*/NS_ENUM(NSInteger, CGLayoutAttribute) {
    
    CGLayoutAttributeLeft       = NSLayoutAttributeLeft,
    CGLayoutAttributeRight      = NSLayoutAttributeRight,
    CGLayoutAttributeTop        = NSLayoutAttributeTop,
    CGLayoutAttributeBottom     = NSLayoutAttributeBottom,
    CGLayoutAttributeLeading    = NSLayoutAttributeLeading,
    CGLayoutAttributeTrailing   = NSLayoutAttributeTrailing,
    
    CGLayoutAttributeWidth      = NSLayoutAttributeWidth,
    CGLayoutAttributeHeight     = NSLayoutAttributeHeight,
    
    CGLayoutAttributeCenterX    = NSLayoutAttributeCenterX,
    CGLayoutAttributeCenterY    = NSLayoutAttributeCenterY,
    
    CGLayoutAttributeBaseline   = NSLayoutAttributeBaseline,
    
//    CGLayoutAttributeEdgeAll    = CGLayoutAttributeTop | CGLayoutAttributeLeading | CGLayoutAttributeBottom | CGLayoutAttributeTrailing,
//    
//    CGLayoutAttributeEdgeExcludeTop         = CGLayoutAttributeLeading | CGLayoutAttributeBottom | CGLayoutAttributeTrailing,
//    
//    CGLayoutAttributeEdgeExcludeLeading     = CGLayoutAttributeTop | CGLayoutAttributeBottom | CGLayoutAttributeTrailing,
//    
//    CGLayoutAttributeEdgeExcludeBottom      = CGLayoutAttributeTop | CGLayoutAttributeLeading | CGLayoutAttributeTrailing,
//    
//    CGLayoutAttributeEdgeExcludeTrailing    = CGLayoutAttributeTop | CGLayoutAttributeLeading | CGLayoutAttributeBottom,
};

typedef NS_ENUM(NSInteger, CGLayoutEdge) {
    
    CGLayoutEdgeNone        = 0,
    CGLayoutEdgeLeft        = CGLayoutAttributeLeft,
    CGLayoutEdgeRight       = CGLayoutAttributeRight,
    CGLayoutEdgeTop         = CGLayoutAttributeTop,
    CGLayoutEdgeLeading     = CGLayoutAttributeLeading,
    CGLayoutEdgeBottom      = CGLayoutAttributeBottom,
    CGLayoutEdgeTrailing    = CGLayoutAttributeTrailing,
};

typedef NS_ENUM(NSInteger, CGDimension) {
    
    CGDimensionWidth        = CGLayoutAttributeWidth,
    CGDimensionHeight       = CGLayoutAttributeHeight,
};

typedef NS_ENUM(NSInteger, CGAxis) {
    
    CGAxisVertical          = CGLayoutAttributeCenterX,
    CGAxisHorizontal        = CGLayoutAttributeCenterY,
    CGAxisBaseline          = CGLayoutAttributeBaseline,
};

#endif /* CGLayoutConstraintsTypeHeader_h */
