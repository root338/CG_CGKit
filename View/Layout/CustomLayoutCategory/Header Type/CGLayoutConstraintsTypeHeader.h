//
//  CGLayoutConstraintsTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 16/3/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#ifndef CGLayoutConstraintsTypeHeader_h
#define CGLayoutConstraintsTypeHeader_h

@import UIKit;

typedef NS_ENUM(NSInteger, CGLayoutRelation) {
    
    CGLayoutRelationLessThanOrEqual     = NSLayoutRelationLessThanOrEqual,
    CGLayoutRelationEqual               = NSLayoutRelationEqual,
    CGLayoutRelationGreaterThanOrEqual  = NSLayoutRelationGreaterThanOrEqual,
};

typedef NS_ENUM(NSInteger, CGLayoutAttribute) {
    
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
    
    CGLayoutAttributeLastBaseline   = NSLayoutAttributeLastBaseline,
    CGLayoutAttributeBaseline       = NSLayoutAttributeBaseline,
    CGLayoutAttributeFirstBaseline NS_ENUM_AVAILABLE_IOS(8_0)   = NSLayoutAttributeFirstBaseline,
    
    CGLayoutAttributeLeftMargin NS_ENUM_AVAILABLE_IOS(8_0)  = NSLayoutAttributeLeftMargin,
    CGLayoutAttributeRightMargin NS_ENUM_AVAILABLE_IOS(8_0) = NSLayoutAttributeRightMargin,
    CGLayoutAttributeTopMargin NS_ENUM_AVAILABLE_IOS(8_0)   = NSLayoutAttributeTopMargin,
    CGLayoutAttributeBottomMargin NS_ENUM_AVAILABLE_IOS(8_0)    = NSLayoutAttributeBottomMargin,
    CGLayoutAttributeLeadingMargin NS_ENUM_AVAILABLE_IOS(8_0)   = NSLayoutAttributeLeadingMargin,
    CGLayoutAttributeTrailingMargin NS_ENUM_AVAILABLE_IOS(8_0)  = NSLayoutAttributeTrailingMargin,
    CGLayoutAttributeCenterXWithinMargins NS_ENUM_AVAILABLE_IOS(8_0)    = NSLayoutAttributeCenterXWithinMargins,
    CGLayoutAttributeCenterYWithinMargins NS_ENUM_AVAILABLE_IOS(8_0)    = NSLayoutAttributeCenterYWithinMargins,
    
    CGLayoutAttributeNotAnAttribute = NSLayoutAttributeNotAnAttribute,
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

NS_AVAILABLE_IOS(8_0)
typedef NS_ENUM(NSInteger, CGLayoutAttributeMargin) {
    
    CGLayoutAttributeMarginLeft     = CGLayoutAttributeLeftMargin,
    CGLayoutAttributeMarginRight    = CGLayoutAttributeRightMargin,
    CGLayoutAttributeMarginTop      = CGLayoutAttributeTopMargin,
    CGLayoutAttributeMarginBottom   = CGLayoutAttributeBottomMargin,
    CGLayoutAttributeMarginLeading  = CGLayoutAttributeLeadingMargin,
    CGLayoutAttributeMarginTrailing = CGLayoutAttributeTrailingMargin,
    CGLayoutAttributeMarginCenterX  = CGLayoutAttributeCenterXWithinMargins,
    CGLayoutAttributeMarginCenterY  = CGLayoutAttributeCenterYWithinMargins,
    
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

typedef NS_OPTIONS(NSInteger, CGLayoutOptionEdge) {
    
    CGLayoutOptionEdgeNone      = 0,
    CGLayoutOptionEdgeLeft      = 1 << 0,
    CGLayoutOptionEdgeRight     = 1 << 1,
    CGLayoutOptionEdgeTop       = 1 << 2,
    CGLayoutOptionEdgeLeading   = 1 << 3,
    CGLayoutOptionEdgeBottom    = 1 << 4,
    CGLayoutOptionEdgeTrailing  = 1 << 5,
    
    CGLayoutOptionEdgeVertical      = CGLayoutOptionEdgeTop | CGLayoutOptionEdgeBottom,
    CGLayoutOptionEdgeHorizontal    = CGLayoutOptionEdgeLeading | CGLayoutOptionEdgeTrailing,
    CGLayoutOptionEdgeHorizontal2   = CGLayoutOptionEdgeLeft | CGLayoutOptionEdgeRight,
    
    CGLayoutOptionEdgeLeftTop       = CGLayoutOptionEdgeLeading | CGLayoutOptionEdgeTop,
    CGLayoutOptionEdgeLeftBottom    = CGLayoutOptionEdgeLeading | CGLayoutOptionEdgeBottom,
    CGLayoutOptionEdgeRightTop      = CGLayoutOptionEdgeTop | CGLayoutOptionEdgeTrailing,
    CGLayoutOptionEdgeRightBottom   = CGLayoutOptionEdgeTrailing | CGLayoutOptionEdgeBottom,
    
    CGLayoutOptionEdgeAll           = CGLayoutOptionEdgeVertical | CGLayoutOptionEdgeHorizontal,
};



#endif /* CGLayoutConstraintsTypeHeader_h */
