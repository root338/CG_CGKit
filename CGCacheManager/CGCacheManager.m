//
//  CGCacheManager.m
//  TestCG_CGKit
//
//  Created by DY on 2016/10/14.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCacheManager.h"

@interface CGCacheManager ()<NSCacheDelegate>
{
    NSCache *_cache;
}

@end

@implementation CGCacheManager

+ (instancetype)defalutManager
{
    static CGCacheManager *cacheManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cacheManager    = [[CGCacheManager alloc] init];
    });
    return cacheManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache  = [[NSCache alloc] init];
    }
    return self;
}

- (void)setObject:(id)object forKey:(id)key
{
    [_cache setObject:object forKey:key];
}

- (nullable id)objectForKey:(id)key
{
    return [_cache objectForKey:key];
}

- (void)removeObjectForKey:(id)key
{
    [_cache removeObjectForKey:key];
}

- (void)removeAllObjects
{
    [_cache removeAllObjects];
}

#pragma mark - NSCacheDelegate

- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    //缓存对象即将要被删除时调用
    if ([self.delegate respondsToSelector:@selector(cacheManager:cache:willEvictObject:)]) {
        [self.delegate cacheManager:self cache:cache willEvictObject:obj];
    }
}

#pragma mark - 设置属性
- (void)setCountLimit:(NSUInteger)countLimit
{
    _countLimit         = countLimit;
    _cache.countLimit   = countLimit;
}

- (void)setTotalCostLimit:(NSUInteger)totalCostLimit
{
    _totalCostLimit         = totalCostLimit;
    _cache.totalCostLimit   = totalCostLimit;
}
@end
