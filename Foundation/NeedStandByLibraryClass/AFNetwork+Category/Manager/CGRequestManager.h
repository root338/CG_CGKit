//
//  CGRequestManager.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGUserInfoModel.h"

@class CGRequestBaseModel;
@class CGRequestModel;
@class AFHTTPRequestOperation;

NS_ASSUME_NONNULL_BEGIN
#pragma mark - 定义block
/** 请求成功的回调block */
typedef void (^SuccessForRequestResult) (AFHTTPRequestOperation *operation, id responseObject);

/** 请求失败的回调block */
typedef void (^FailureForRequestResult)   (AFHTTPRequestOperation *operation, NSError *error);

/** 不管请求成功或失败都回调的block */
typedef void (^CompletionForRequestResult) (AFHTTPRequestOperation *operation);

/**
 *  网络请求管理类
 *  基于AFNetwork网络请求库
 */
@interface CGRequestManager : NSObject

/** 创建管理类的单例 */
+ (instancetype)sharedManager;

#pragma mark - 用户数据
@property (strong, nonatomic) CGUserInfoModel *currentUserInfo;


#pragma mark - 网络请求数据


#pragma mark - 请求数据接口

- (AFHTTPRequestOperation *)requestWithModel:(CGRequestModel *)requestModel success:(SuccessForRequestResult)success failure:(FailureForRequestResult)failure completion:(CompletionForRequestResult)completion;

@end
NS_ASSUME_NONNULL_END