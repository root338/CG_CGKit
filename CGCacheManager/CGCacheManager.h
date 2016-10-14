//
//  CGCacheManager.h
//  TestCG_CGKit
//
//  Created by DY on 2016/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CGCacheManagerDelegate;

//CG_CGKit一些数据的缓存处理，使用NSCache来实现，API统一 NSCache API
@interface CGCacheManager<KeyType, ObjectType> : NSObject

//默认管理处理
+ (instancetype)defalutManager;

@property (nullable, nonatomic, weak) id<CGCacheManagerDelegate> delegate;

@property (nonatomic, assign) NSUInteger totalCostLimit;
@property (nonatomic, assign) NSUInteger countLimit;

- (nullable ObjectType)objectForKey:(KeyType)key;

- (void)setObject:(ObjectType)object forKey:(KeyType)key;

- (void)removeObjectForKey:(KeyType)key;
- (void)removeAllObjects;

@end

@protocol CGCacheManagerDelegate <NSObject>

@optional
- (void)cacheManager:(CGCacheManager *)cacheManager cache:(NSCache *)cache willEvictObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
