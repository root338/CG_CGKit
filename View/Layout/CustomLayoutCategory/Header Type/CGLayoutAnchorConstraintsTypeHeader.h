//
//  CGLayoutAnchorConstraintsTypeHeader.h
//  CGPhoto
//
//  Created by DY on 2017/11/16.
//  Copyright © 2017年 DY. All rights reserved.
//

#ifndef CGLayoutAnchorConstraintsTypeHeader_h
#define CGLayoutAnchorConstraintsTypeHeader_h

typedef NS_ENUM(NSInteger, CGLayoutXAxisAnchorType) {
    
    CGLayoutXAxisAnchorTypeLeading,
    CGLayoutXAxisAnchorTypeTrailing,
    CGLayoutXAxisAnchorTypeLeft,
    CGLayoutXAxisAnchorTypeRight,
    CGLayoutXAxisAnchorTypeCenterX,
};

typedef NS_ENUM(NSInteger, CGLayoutYAxisAnchorType) {
    
    CGLayoutYAxisAnchorTypeTop,
    CGLayoutYAxisAnchorTypeBottom,
    CGLayoutYAxisAnchorTypeCenterY,
};

typedef NS_ENUM(NSInteger, CGLayoutDimensionAnchorType) {
    
    CGLayoutDimensionAnchorTypeWidth,
    CGLayoutDimensionAnchorTypeHeight,
};

#endif /* CGLayoutAnchorConstraintsTypeHeader_h */
