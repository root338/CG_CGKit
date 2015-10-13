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
@end

@implementation NSString (VerificationPhone)



@end