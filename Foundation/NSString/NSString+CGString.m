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
@end
