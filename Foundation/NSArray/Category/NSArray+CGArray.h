//
//  NSArray+CGArray.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/6.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (CGArray)

- (BOOL)cg_veriftyArray;

- (BOOL)cg_judgeIsZeroLengthArray;

- (NSArray<ObjectType> *)cg_arrayByAddingObjectsFromArray:(NSArray<ObjectType> *)otherArray;

- (ObjectType)cg_objectAtIndex:(NSUInteger)index;

+ (instancetype)cg_arrayWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
@end

@interface NSMutableArray<ObjectType> (CGMutableArray)

- (BOOL)cg_addObjectsFromArray:(NSArray<ObjectType> *)otherArray;

@end