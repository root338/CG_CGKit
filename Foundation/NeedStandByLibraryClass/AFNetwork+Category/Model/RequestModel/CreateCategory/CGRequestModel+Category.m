//
//  CGRequestModel+CreateRequestModel.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestModel+Category.h"
#import "NSString+VerificationString.h"

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

@implementation CGRequestModel (NewUpdateRequestModel)

- (CGRequestModel *)requestWithUpdateBaseModel:(CGRequestBaseModel *)baseRequestModel
{
    CGRequestModel *requestModel = [self copy];
    
    if (![requestModel.pathURL verificationIsHTTPPrefix]) {
        requestModel.pathURL = [baseRequestModel.baseURL stringByAppendingString:requestModel.pathURL];
    }
    
    if (!requestModel.isApplyHTTPRequestType) {
        requestModel.HTTPRequestType = baseRequestModel.HTTPRequestType;
    }
    
    if (!requestModel.isApplyHTTPRequestBodyType) {
        requestModel.HTTPRequestBodyType = baseRequestModel.HTTPRequestBodyType;
    }
    
    if (!requestModel.HTTPHeaderParameters) {
        requestModel.HTTPHeaderParameters = baseRequestModel.HTTPHeaderParameters;
    }
    
    if (!requestModel.isApplyShowPromptView) {
        requestModel.isShowPromptView = baseRequestModel.isShowPromptView;
        requestModel.delayTimeInterval = baseRequestModel.delayTimeInterval;
        requestModel.loadingPromptString = baseRequestModel.loadingPromptString;
    }
    
    return nil;
}

@end