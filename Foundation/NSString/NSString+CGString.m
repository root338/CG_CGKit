//
//  NSString+CGString.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSString+CGString.h"
#import <objc/runtime.h>

@interface NSMutableString (_CGStringPrivate)<GMLAddStringProtocol>
@property (nonatomic, strong) NSMutableArray *_gml_strings;
- (void)_gml_clearAddStringCache;
@end

@implementation NSString (CGString)

- (NSString *)cg_stringByAppendingString:(NSString *)aString
{
    NSString *newStr = nil;
    if (self.length && aString.length) {
        newStr = [self stringByAppendingString:aString];
    }else {
        newStr = self.length ? self : aString;
    }
    return newStr;
}

- (NSString *)cg_stringIgnoreWhitespaceAndNewlineCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)cg_stringIgnoreWhitespaceCharacterSet
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)cg_removeLastString
{
    if (self.length) {
        return [self substringToIndex:self.length - 1];
    }
    return self;
}

- (NSString *)cg_stringRemovalRedundantWhitespace
{
    NSString *str   = [self cg_stringIgnoreWhitespaceCharacterSet];
    NSArray *components = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components  = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    NSString *string    = [components componentsJoinedByString:@" "];
    return string;
}

@end

@implementation NSMutableString (CGMutableString)

+ (NSMutableString *)cg_stringComponentsJoinedByString:(NSString *)separator usingBlock:(void (NS_NOESCAPE^)(id<GMLAddStringProtocol> _Nonnull))usingBlock {
    NSMutableString *mStr = NSMutableString.string;
    !usingBlock?: usingBlock(mStr);
    [mStr appendString:[mStr._gml_strings componentsJoinedByString:separator]];
    [mStr _gml_clearAddStringCache];
    return mStr;
}

- (void)removeLastString
{
    if (self.length) {
        [self deleteCharactersInRange:NSMakeRange(self.length - 1, 1)];
    }
}

@end

@implementation NSMutableString (GMLAddStringProtocol)

#pragma mark - GMLAddStringProtocol
- (id<GMLAddStringProtocol>)cg_appendString:(NSString *)string {
    GMLAddStringIgnore ignore = self.cg_ignoreValue;
    BOOL isNull = string == nil || [string isKindOfClass:NSNull.class];
    NSString *newStr = nil;
    if (ignore & GMLAddStringIgnoreNull) {
        if (isNull) {
            return self;
        }
    }
    if (ignore & GMLAddStringIgnoreWhitespaceAndNewline) {
        if (!isNull) {
            newStr = [string stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
            if (newStr.length == 0) {
                return self;
            }
        }
    }
    if (newStr == nil) {
        newStr = isNull ? [NSString stringWithFormat:@"%@", string] : string;
    }
    if (self.cg_willAppendStringHandle) {
        newStr = self.cg_willAppendStringHandle(newStr);
    }
    CGDebugAssert(newStr, @"为空");
    if (newStr == nil) {
        return self;
    }
    [self._gml_strings addObject:newStr];
    return self;
}

- (id<GMLAddStringProtocol> _Nonnull (^)(NSString * _Nonnull))cg_appendString {
    return ^(NSString *str) {
        return [self cg_appendString:str];
    };
}

- (void)setCg_willAppendStringHandle:(NSString * _Nonnull (^)(NSString * _Nonnull))block {
    objc_setAssociatedObject(self, @selector(cg_willAppendStringHandle), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))cg_willAppendStringHandle {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)_gml_clearAddStringCache {
    objc_setAssociatedObject(self, @selector(_gml_strings), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(cg_ignoreValue), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCg_ignoreValue:(GMLAddStringIgnore)value {
    objc_setAssociatedObject(self, @selector(cg_ignoreValue), @(value), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GMLAddStringIgnore)cg_ignoreValue {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj == nil) {
        return GMLAddStringIgnoreAll;
    }
    return [obj integerValue];
}

- (NSMutableArray *)_gml_strings {
    
    NSMutableArray *mArr = objc_getAssociatedObject(self, _cmd);
    if (mArr) {
        return mArr;
    }
    mArr = NSMutableArray.array;
    objc_setAssociatedObject(self, _cmd, mArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return mArr;
}

@end
