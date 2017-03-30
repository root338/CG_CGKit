//
//  NSDictionary+CGKeyIndexPath.m
//  QuickAskCommunity
//
//  Created by DY on 2017/3/29.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "NSDictionary+CGKeyIndexPath.h"

#import "CGVerifyIOSVersionHeader.h"

@interface NSIndexPath (_CGDictionaryIndexPathKey)

- (NSString *)descriptionKey;

@end

@implementation NSDictionary (CGKeyIndexPath)

- (nullable id)objectForIndexPathKey:(NSIndexPath *)indexPath
{
//    if (_CG_IOS_8_0_AFTER) {
//        return [self objectForKey:indexPath];
//    }else {
        return [self objectForKey:[indexPath descriptionKey]];
//    }
}

@end

@implementation NSMutableDictionary (CGKeyIndexPath)

- (void)removeObjectForIndexPathKey:(NSIndexPath *)indexPath
{
//    if (_CG_IOS_8_0_AFTER) {
//        [self removeObjectForKey:indexPath];
//    }else {
        [self removeObjectForKey:[indexPath descriptionKey]];
//    }
    
}

- (void)setObject:(id)anObject forIndexPathKey:(NSIndexPath *)indexPath
{
//    if (_CG_IOS_8_0_AFTER) {
//        [self setObject:anObject forKey:indexPath];
//    }else {
        [self setObject:anObject forKey:[indexPath descriptionKey]];
//    }
}

@end

@implementation NSIndexPath (_CGDictionaryIndexPathKey)

- (NSString *)descriptionKey
{
    return [NSString stringWithFormat:@"section:%li, row:%li", (long)self.section, (long)self.row];
}

@end
