//
//  CGLineBoxTypeHeader.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/14.
//  Copyright © 2015年 apple. All rights reserved.
//

#ifndef CGLineBoxTypeHeader_h
#define CGLineBoxTypeHeader_h

typedef NS_OPTIONS(NSInteger, LineBoxType) {
    
    LineBoxTypeTop      = 1 << 0,
    LineBoxTypeLeft     = 1 << 1,
    LineBoxTypeBottom   = 1 << 2,
    LineBoxTypeRight    = 1 << 3,
    LineBoxTypeAll      = LineBoxTypeTop | LineBoxTypeLeft | LineBoxTypeBottom | LineBoxTypeRight,
};

typedef NS_OPTIONS(NSInteger, CGLineBoxType) {

    CGLineBoxTypeNone       = 0,
    CGLineBoxTypeTop        = 1 << 0,
    CGLineBoxTypeLeft       = 1 << 1,
    CGLineBoxTypeBottom     = 1 << 2,
    CGLineBoxTypeRight      = 1 << 3,
    
    CGLineBoxTypeAll      = CGLineBoxTypeTop | CGLineBoxTypeLeft | CGLineBoxTypeBottom | CGLineBoxTypeRight,
};

#endif /* CGLineBoxTypeHeader_h */
