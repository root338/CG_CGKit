//
//  NSString+CGStrlen.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  链接的拼接类型
 */
typedef NS_ENUM(NSInteger, CGStrlenType) {
    /**
     *  路径式 /key/value
     */
    CGStrlenTypePath,
    /**
     *  键值对 &key=value 当没有？时为 ?key=value
     */
    CGStrlenTypeKeyValuePairs,
};

@interface NSString (CGStrlen)

/**
 *  HTTP链接的拼接
 *
 *  @param key 参数
 *  @param obj 值
 *
 *  @return 返回拼接后的链接
 */
- (nullable NSString *)cg_urlPathTypeStrlenWithKey:(NSString *)key object:(NSString *)obj;

/**
 *  HTTP链接的拼接
 *
 *  @param key 参数
 *  @param obj 值
 *
 *  @return 返回拼接后的链接
 */
- (nullable NSString *)cg_urlKey_ValuePairsTypeStrlenWithKey:(NSString *)key object:(NSString *)obj;

/**
 *  HTTP链接的拼接
 *
 *  @param key  参数
 *  @param obj  值
 *  @param type 拼接的类型
 *
 *  @return 返回拼接后的链接
 */
- (nullable NSString *)cg_urlStrlenWithKey:(NSString *)key object:(NSString *)obj type:(CGStrlenType)type;
@end
NS_ASSUME_NONNULL_END