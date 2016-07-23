//
//  NSPredicate+CreatePredicate.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//


#import "NSPredicate+CreatePredicate.h"

#import "CGPrintLogHeader.h"

@implementation NSPredicate (CreatePredicate)

+ (instancetype)createPredicateSelfMatchesWithString:(NSString *)string
{
    NSPredicate *predicate = [self predicateWithFormat:@"SELF MATCHES %@", string];
    return predicate;
}

+ (instancetype)createPredicateSelfHasPrefixWithString:(NSString *)string
{
    NSPredicate *predicate  = [self predicateWithFormat:@"SELF BEGINSWITH[c] %@", string];
    return predicate;
}

+ (instancetype)createPredicateWithType:(CGPredicateCreateType)createType string:(NSString *)string
{
    return [self createPredicateWithType:createType string:string error:nil];
}

+ (instancetype)createPredicateWithType:(CGPredicateCreateType)createType string:(NSString *)string error:(NSError *__autoreleasing  _Nullable * _Nullable)error
{
    NSString *prefixStr = nil;
    switch (createType) {
        case CGPredicateCreateTypeIgnoreCaseMatches:
            prefixStr   = @"SELF MATCHES[c] %@";
            break;
        case CGPredicateCreateTypeMatches:
            prefixStr   = @"SELF MATCHES %@";
            break;
        default:
            break;
    }
    
    NSPredicate *predicate  = nil;
    NSError *err            = nil;
    @try {
        predicate   = [NSPredicate predicateWithFormat:prefixStr, string];
    }
    @catch (NSException *exception) {
        
        CGErrorLog(@"%@, %@", exception.name, exception.reason);
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithDictionary:exception.userInfo];
        !exception.reason ?: [userInfo setObject:exception.reason forKey:NSLocalizedDescriptionKey];
        err = [NSError errorWithDomain:exception.name code:-1 userInfo:userInfo];
        
        if (error != NULL) {
            *error   = err;
        }
        
        CGDebugAssert(!err, @"创建NSPredicate失败");
    }
    @finally {
        
    }
    return predicate;
}

@end


//Format：
//(1)比较运算符>,<,==,>=,<=,!=
//可用于数值及字符串
//例：@"number > 100"
//
//
//(2)范围运算符：IN、BETWEEN
//例：@"number BETWEEN {1,5}"
//@"address IN {'shanghai','beijing'}"
//
//
//(3)字符串本身:SELF
//例：@“SELF == ‘APPLE’"
//
//
//(4)字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
//例：@"name CONTAIN[cd] 'ang'"   //包含某个字符串
//@"name BEGINSWITH[c] 'sh'"     //以某个字符串开头
//@"name ENDSWITH[d] 'ang'"      //以某个字符串结束
//注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
//
//
//(5)通配符：LIKE
//例：@"name LIKE[cd] '*er*'"    //*代表通配符,Like也接受[cd].
//@"name LIKE[cd] '???er*'"
//
//(6)正则表达式：MATCHES
//例：NSString *regex = @"^A.+e$";   //以A开头，e结尾
//@"name MATCHES %@",regex