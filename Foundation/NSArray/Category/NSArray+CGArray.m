//
//  NSArray+CGArray.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/6.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSArray+CGArray.h"

@implementation NSArray (CGArray)

/** 是否越界 */
- (BOOL)isTransboundaryAtIndex:(NSUInteger)index
{
    return index >= self.count;
}

- (id)cg_objectAtIndex:(NSUInteger)index
{
    if ([self isTransboundaryAtIndex:index]) {
#ifdef DEBUG
        NSAssert(nil, @"数组越界");
#endif
        return nil;
    }
    
    return [self objectAtIndex:index];
}

+ (instancetype)cg_arrayWithObjects:firstObj, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *arr = nil;
    
    id eachObject;
    va_list argumentList;
    
    if (firstObj) {
        
        arr = [NSMutableArray arrayWithObject:firstObj];
        
        va_start(argumentList, firstObj);
        while ((eachObject = va_arg(argumentList, id))) {
            
            [arr addObject:eachObject];
        }
        va_end(argumentList);
        
        return arr;
    }
    return arr;
}
@end
