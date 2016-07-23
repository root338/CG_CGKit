//
//  NSPredicate+CreatePredicate.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 创建正则表达式的类型 */
typedef NS_ENUM(NSInteger, CGPredicateCreateType) {
    /** 添加 SELF MATCHES 方式验证字符串 */
    CGPredicateCreateTypeMatches,
    /** 添加 SELF MATCHES[c] 方式验证字符串 */
    CGPredicateCreateTypeIgnoreCaseMatches,
};

@interface NSPredicate (CreatePredicate)

/** 正则表达式，表示字符串是否满足给定正则表达式 */
+ (instancetype)createPredicateSelfMatchesWithString:(NSString *)string;

/** 判断字符串是否已给定表达式开头(不区分大小写) */
+ (instancetype)createPredicateSelfHasPrefixWithString:(NSString *)string;

+ (nullable instancetype)createPredicateWithType:(CGPredicateCreateType)createType string:(NSString *)string;
+ (nullable instancetype)createPredicateWithType:(CGPredicateCreateType)createType string:(NSString *)string error:(NSError * _Nullable *)error;
@end

NS_ASSUME_NONNULL_END