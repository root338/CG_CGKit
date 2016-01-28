//
//  NSObject+CGGetPrivateAPI.h
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, CGPrintLogType) {
    
    CGPrintLogTypeMethod    = 1 << 0,
    CGPrintLogTypeProperty  = 1 << 1,
    CGPrintLogTypeAll       = CGPrintLogTypeMethod | CGPrintLogTypeProperty,
    
};

@interface NSObject (CGGetPrivateAPI)

- (void)cg_printAllWithType:(CGPrintLogType)type;

@end
