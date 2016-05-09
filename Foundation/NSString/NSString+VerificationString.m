//
//  NSString+VerificationString.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/9.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSString+VerificationString.h"
#import "NSPredicate+CreatePredicate.h"

@implementation NSString (VerificationString)

- (BOOL)verificationIsHTTPPrefix
{
    NSString *tmpStr = [self lowercaseString];
    if ([tmpStr hasPrefix:@"http://"] || [tmpStr hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}

- (BOOL)verificationIsAllNumber
{
    
    NSPredicate *predicate = [NSPredicate createPredicateSelfMatchesWithString:@"\\d{1,}"];
    return [predicate evaluateWithObject:self];
}

- (BOOL)verificationIsChineseCharacter
{
    //(unicode中文编码范围是0x4e00~0x9fa5)
    
    BOOL isResult = self.length;
    
    for (NSUInteger index = 0; index < self.length; index++) {
        unichar a = [self characterAtIndex:index];
        if (a <= 0x4e00 || a >= 0x9fa5) {
            
            //不是中文字符跳出循环
            isResult = NO;
            continue;
        }
    }
    return isResult;
}

//- (BOOL)verificationIsPhone
//{
//    BOOL isResult   = NO;
//    
//    
//    
//    return isResult;
//}
@end
