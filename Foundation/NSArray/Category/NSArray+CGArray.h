//
//  NSArray+CGArray.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/6.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define CGIsArray(a) ((a) != nil && [(a) isKindOfClass:NSArray.class])
#define CGIsNotEmptyArray(a) ((CGIsArray(a)) && [(a) count] > 0)

@interface NSArray<ObjectType> (CGArray)

@property (nonatomic, assign, readonly) BOOL isEmptyCG;

+ (instancetype)cg_arrayWithObjects:(ObjectType)firstObj, ... NS_REQUIRES_NIL_TERMINATION;

/// 等价 arrayByAddingObjectsFromArray:
- (nullable NSArray<ObjectType> *)cg_arrayByAddingObjectsFromArray:(nullable NSArray<ObjectType> *)otherArray;

- (nullable ObjectType)cg_objectAtIndex:(NSUInteger)index;
/// 从 0 到 index, 没有 location == NSNotFound
- (NSRange)cg_rangeToIndex:(NSInteger)index;
/// 从 index 到数组结尾，没有 location == NSNotFound
- (NSRange)cg_rangeFromIndex:(NSInteger)index;
/// 循环索引，< 0 时从最后获取
- (nullable ObjectType)cg_objectAtCycleIndex:(NSInteger)index;
@end

@interface NSMutableArray<ObjectType> (CGMutableArray)

- (BOOL)cg_addObjectsFromArray:(nullable NSArray<ObjectType> *)otherArray;

- (nullable ObjectType)cg_removeObjectAtIndex:(NSUInteger)index;

- (void)cg_addObject:(ObjectType)anObject;

@end
NS_ASSUME_NONNULL_END
