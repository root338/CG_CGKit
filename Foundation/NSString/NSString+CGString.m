//
//  NSString+CGString.m
//  QuickAskCommunity
//
//  Created by DY on 16/1/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSString+CGString.h"

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

- (void)removeLastString
{
    if (self.length) {
        [self deleteCharactersInRange:NSMakeRange(self.length - 1, 1)];
    }
}

@end
