//
//  NSArray+CGArray.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/6.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSArray<ObjectType> (CGArray)

- (BOOL)cg_veriftyArray;

- (BOOL)cg_judgeIsZeroLengthArray;

- (nullable NSArray<ObjectType> *)cg_arrayByAddingObjectsFromArray:(nullable NSArray<ObjectType> *)otherArray;

- (ObjectType)cg_objectAtIndex:(NSUInteger)index;

+ (instancetype)cg_arrayWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
@end

@interface NSMutableArray<ObjectType> (CGMutableArray)

- (BOOL)cg_addObjectsFromArray:(nullable NSArray<ObjectType> *)otherArray;

- (nullable ObjectType)cg_removeObjectAtIndex:(NSUInteger)index;

- (void)cg_addObject:(ObjectType)anObject;

@end
NS_ASSUME_NONNULL_END
