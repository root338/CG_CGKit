//
//  CGRequestModel+CreateRequestModel.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestModel+CreateRequestModel.h"

@implementation CGRequestModel (CreateRequestModel)

+ (instancetype)createRequestModelWithPathURL:(NSString *)pathURL parameters:(NSDictionary *)parameters resolveResponseClass:(Class)resolveResponseClass
{
    CGRequestModel *requestModel = [[CGRequestModel alloc] init];
    
    requestModel.pathURL    = pathURL;
    requestModel.parameters = parameters;
    
    if (resolveResponseClass) {
        requestModel.isAutoResolveResponse  = YES;
        requestModel.resolveResponseClass   = resolveResponseClass;
    }
    
    return requestModel;
}

@end
