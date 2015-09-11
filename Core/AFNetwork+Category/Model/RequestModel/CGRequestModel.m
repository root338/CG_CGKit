//
//  CGRequestModel.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestModel.h"

@implementation CGRequestModel

- (id)copyWithZone:(NSZone *)zone
{
    
    CGRequestModel *requestModel = [super copyWithZone:zone];
    
    requestModel.pathURL = [self.pathURL copy];
    
    requestModel.parameters = [self.parameters copy];
    
    requestModel.resolveResponseClass = self.resolveResponseClass;
    requestModel.isAutoResolveResponse = self.isAutoResolveResponse;
    
    requestModel.isApplyHTTPRequestType = self.isApplyHTTPRequestType;
    requestModel.isApplyHTTPRequestBodyType = self.isApplyHTTPRequestBodyType;
    requestModel.isApplyShowPromptView = self.isApplyShowPromptView;
    
    return requestModel;
}

@end
