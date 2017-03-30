//
//  NSDictionary+CGKeyIndexPath.h
//  QuickAskCommunity
//
//  Created by DY on 2017/3/29.
//  Copyright © 2017年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 
 *  在iOS 7， iOS 8 使用 OC 语言，用NSDictionary<NSIndexPath *, NSNumber *> *存储cell高度时，NSIndexPath 的数值不唯一
 *  相同的section， row 生成的NSIndexPath 类型key会删除多个
 */

NS_ASSUME_NONNULL_BEGIN


@interface NSDictionary<KeyType, ObjectType> (CGKeyIndexPath)

- (nullable ObjectType)objectForIndexPathKey:(NSIndexPath *)indexPath;

@end

@interface NSMutableDictionary<KeyType, ObjectType> (CGKeyIndexPath)

- (void)removeObjectForIndexPathKey:(NSIndexPath *)indexPath;
- (void)setObject:(ObjectType)anObject forIndexPathKey:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
