//
//  NSString+CGStrlen.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/6.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSString+CGStrlen.h"

@implementation NSString (CGStrlen)

- (NSRange)cg_searchURLParam
{
    return [self rangeOfString:@"?"];
}

- (NSString *)cg_urlStrlenWithKey:(NSString *)key object:(NSString *)obj type:(CGStrlenType)type
{
    NSString *resultLink = nil;
    switch (type) {
        case CGStrlenTypePath:
            resultLink  = [self cg_urlPathTypeStrlenWithKey:key object:obj];
            break;
        case CGStrlenTypeKeyValuePairs:
            resultLink  = [self cg_urlKey_ValuePairsTypeStrlenWithKey:key object:obj];
            break;
        default:
            break;
    }
    
    return resultLink;
}

- (NSString *)cg_urlPathTypeStrlenWithKey:(NSString *)key object:(NSString *)obj
{
    if (![self cg_private_judgeParametersWithKey:key obj:obj]) {
        return self;
    }
    
    NSRange   range           = [self rangeOfString:@"?"];
    NSString  *parameterStr   = nil;
    NSString  *linkStr        = nil;
    
    if (range.location != NSNotFound) {
        parameterStr    = [self substringToIndex:range.location];
        linkStr         = [self substringFromIndex:range.location];
    }else {
        linkStr         = self;
    }
    
    NSMutableString *linkMutableStr = [NSMutableString stringWithString:linkStr];
    
    NSString *addNewLink = [NSString stringWithFormat:@"/%@/%@", key, obj];
    if ([linkStr hasSuffix:@"/"]) {
        addNewLink = [addNewLink substringFromIndex:1];
    }
    
    [linkMutableStr appendString:addNewLink];
    !parameterStr ?: [linkMutableStr appendString:parameterStr];
    
    return linkMutableStr;
}

- (NSString *)cg_urlKey_ValuePairsTypeStrlenWithKey:(NSString *)key object:(NSString *)obj
{
    if (![self cg_private_judgeParametersWithKey:key obj:obj]) {
        return self;
    }
    
    NSRange         range           = [self rangeOfString:@"?"];
    NSString        *parameterStr   = range.location != NSNotFound ? @"?" : @"&";
    NSMutableString *linkMutableStr = [NSMutableString stringWithString:self];
    
    [linkMutableStr appendString:parameterStr];
    return linkMutableStr;
}

- (BOOL)cg_private_judgeParametersWithKey:(NSString *)key obj:(NSString *)obj
{
    BOOL isResult = YES;
    if (!self || !key.length || !obj.length) {
        isResult = NO;
    }
    return isResult;
}

@end
