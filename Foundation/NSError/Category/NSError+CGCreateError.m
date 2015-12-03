//
//  NSError+CGCreateError.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/19.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "NSError+CGCreateError.h"

@implementation NSError (CGCreateError)

+ (NSError *)cg_CreateWithCode:(NSInteger)code errorMessage:(NSString *)errorMessage
{
    if (errorMessage) {
        errorMessage = @"";
    }
    NSDictionary *errorInfo = @{
                                NSLocalizedDescriptionKey : errorMessage,
                                };
    NSError *error = [NSError errorWithDomain:errorMessage code:code userInfo:errorInfo];
    return error;
}

+ (NSError *)cg_CreateWithErrorMessage:(NSString *)errorMessage
{
    return [self cg_CreateWithCode:-1 errorMessage:errorMessage];
}
@end
