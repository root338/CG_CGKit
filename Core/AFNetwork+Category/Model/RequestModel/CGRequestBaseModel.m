//
//  CGRequestBaseModel.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestBaseModel.h"

@implementation CGRequestBaseModel

- (id)copyWithZone:(NSZone *)zone
{
    CGRequestBaseModel *requestModel = [[[self class] allocWithZone:zone] init];
    requestModel.baseURL = [self.baseURL copy];
    requestModel.HTTPRequestType = self.HTTPRequestType;
    requestModel.HTTPRequestBodyType = self.HTTPRequestBodyType;
    requestModel.HTTPHeaderParameters = [self.HTTPHeaderParameters copy];
    requestModel.isShowPromptView = self.isShowPromptView;
    requestModel.delayTimeInterval = self.delayTimeInterval;
    requestModel.loadingPromptString = [self.loadingPromptString copy];
    return requestModel;
}

@end
