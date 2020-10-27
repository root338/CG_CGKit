//
//  NSArray+CGArray.m
//  QuickAskCommunity
//
//  Created by DY on 15/11/6.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSArray+CGArray.h"

#define isAvailableAtIndex(index) (self.count > (index) && (index) >= 0)
 
@implementation NSArray (CGArray)

- (id)cg_objectAtIndex:(NSUInteger)index
{
    if (!isAvailableAtIndex(index)) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (NSArray <id> *)cg_arrayByAddingObjectsFromArray:(NSArray *)otherArray {
    if (CGIsNotEmptyArray(otherArray)) {
        return [self arrayByAddingObjectsFromArray:otherArray];
    }
    return self;
}

- (NSRange)cg_rangeToIndex:(NSInteger)index {
    if (index < 0 || index >= self.count) {
        return NSMakeRange(NSNotFound, NSNotFound);
    }
    return NSMakeRange(0, index);
}

- (NSRange)cg_rangeFromIndex:(NSInteger)index {
    if (index < 0 || index >= self.count) {
        return NSMakeRange(NSNotFound, NSNotFound);
    }
    return NSMakeRange(index, self.count - index);
}

- (id)cg_objectAtCycleIndex:(NSInteger)index {
    NSInteger count = self.count;
    if (count == 0) { return nil; }
    NSInteger i = index >= 0 ? index % self.count : (self.count + index) % self.count;
    return self[i];
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


- (BOOL)isEmptyCG {
    return self.count == 0;
}

@end

@implementation NSMutableArray (CGMutableArray)

- (BOOL)cg_addObjectsFromArray:(NSArray *)otherArray
{
    BOOL isFlag = CGIsNotEmptyArray(otherArray);
    if (isFlag) {
        [self addObjectsFromArray:otherArray];
    }
    return isFlag;
}

- (id)cg_removeObjectAtIndex:(NSUInteger)index
{
    id value = nil;
    if (self.count > index) {
        value = [self objectAtIndex:index];
        [self removeObjectAtIndex:index];
    }
    return value;
}

- (void)cg_addObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end
