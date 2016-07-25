//
//  NSString+VerificationString.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/9.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSString+VerificationString.h"
#import "NSPredicate+CreatePredicate.h"

#import "NSError+CGCreateError.h"

@implementation NSString (VerificationString)

- (BOOL)verificationIsHTTPPrefix
{
    
    NSPredicate *predicate  = [NSPredicate createPredicateWithType:CGPredicateCreateTypeIgnoreCaseMatches string:@"http[s]?://[^\\s]+"];
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

- (BOOL)verificationIsEmailWithError:(NSError * _Nullable __autoreleasing *)error
{
    void (^failureBlock)(NSString *) = ^(NSString *errMsg) {
        
        if (error != NULL) {
            *error  = [NSError cg_createWithErrorMessage:errMsg];
        }
    };
    
    NSRange range   = [self rangeOfString:@"@"];
    if (range.location == NSNotFound) {
        
        failureBlock(@"邮箱必须包含@符");
        return NO;
    }
    
    //获取邮箱名
    NSString *emailName = [self substringToIndex:range.location];
    
    //邮箱开头必须为字母
    NSPredicate *letterPrefix   = [NSPredicate createPredicateWithType:CGPredicateCreateTypeMatches string:@"[a-zA-Z][\\w\\W]*"];
    if (![letterPrefix evaluateWithObject:emailName]) {
        
        failureBlock(@"邮箱必须以字母开头");
        return NO;
    }
    
    //邮箱只能包含字母[a-zA-Z]，数字[0-9]，下划线[_]，点号[.]，减号[-]
//    NSPredicate *
    
    return YES;
}

#pragma mark - 正则表达式判断
- (BOOL)verificationIsAllNumber
{
    NSString *predicateString   = [NSString stringWithFormat:@"\\d{1,}"];
    return [self verifyWithPredicate:predicateString];
}

- (BOOL)verifyNumberWithCount:(NSInteger)count
{
    NSString *predicateString   = [NSString stringWithFormat:@"\\d{%li}", (long)count];
    return [self verifyWithPredicate:predicateString];
}

- (BOOL)verifyWithPredicate:(NSString *)predicateString
{
    NSPredicate *predicate = [NSPredicate createPredicateSelfMatchesWithString:predicateString];
    return [predicate evaluateWithObject:self];
}
@end
