//
//  CGRequestBaseModel+CreateRequestBaseModel.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestBaseModel+CreateRequestBaseModel.h"

@implementation CGRequestBaseModel (CreateRequestBaseModel)

+ (instancetype)createRequestBaseModelWithBaseURL:(NSString *)baseUrl
{
    CGRequestBaseModel *requestBaseModel = [[CGRequestBaseModel alloc] init];
    requestBaseModel.baseURL = baseUrl;
    return requestBaseModel;
}

@end
