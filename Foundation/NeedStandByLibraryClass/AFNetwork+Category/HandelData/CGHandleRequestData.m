//
//  CGHandleRequestData.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/9.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#if __has_include(<JSONModel.h>)

#import "CGHandleRequestData.h"
#import "CGPrintLogHeader.h"
#import "JSONModel.h"

@interface CGHandleRequestData ()

@end

@implementation CGHandleRequestData

+ (instancetype)createResolveWithObject:(id)responseObject isAutoResolveResponse:(BOOL)isAutoResolveResponse resolveResponseClass:(Class)resolveResponseClass
{
    return [[CGHandleRequestData alloc] initWithObject:responseObject
                                 isAutoResolveResponse:isAutoResolveResponse
                                  resolveResponseClass:resolveResponseClass];
}

- (instancetype)initWithObject:(id)responseObject isAutoResolveResponse:(BOOL)isAutoResolveResponse resolveResponseClass:(Class)resolveResponseClass
{
    self = [super init];
    if (self) {
        self.responseObject = responseObject;
        self.isAutoResolveResponse = isAutoResolveResponse;
        self.resolveResponseClass = resolveResponseClass;
    }
    return self;
}

- (id)resolveJSONWithObject:(id)responseObject targetClass:(Class)resolveTarget
{
    
    if (!responseObject) {
        
        return nil;
    }
    
//    id responseValue = nil;
//    if ([responseObject isKindOfClass:[NSData class]]) {
//        NSError *error = nil;
//        responseValue = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
//        
//        CGDebugAssert(!error, @"解析错误");
//    }else {
//        responseValue = responseObject;
//    }
    
    id obj;
    
    NSError *e = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        
        obj = [[resolveTarget alloc] initWithDictionary:responseObject error:&e];
        
        CGDebugAssert1(!e, @"解析字典错误, error : %@", e);
    }else if ([responseObject isKindOfClass:[NSData class]]) {
    
        obj = [[resolveTarget alloc] initWithData:responseObject error:&e];
        
        CGDebugAssert1(!e, @"解析数据流错误 error : %@", e);
    }
    
    return obj;
}

@end

#endif
