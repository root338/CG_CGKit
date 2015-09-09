//
//  CGRequestManager.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "CGRequestBaseModel+CreateRequestBaseModel.h"
#import "AFNetworkActivityLogger.h"

@interface CGRequestManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation CGRequestManager

#pragma mark - 创建对象
+ (instancetype)sharedManager
{
    static CGRequestManager *requestManager = nil;
    static dispatch_once_t CG_CGKit_CGRequestManager_requestManager;
    dispatch_once(&CG_CGKit_CGRequestManager_requestManager, ^{
        requestManager = [[CGRequestManager alloc] init];
    });
    return requestManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initialization];
    }
    return self;
}

#pragma mark - 数据初始化
/** 初始化数据 */
- (void)initialization
{
    [self requestActivityLoggerIsOpen:YES];
    
    self.requestOperationManager = [AFHTTPRequestOperationManager manager];
//    AFHTTPResponseSerializer
    //根据项目的不同而变化
    self.requestBaseModel = [CGRequestBaseModel createRequestBaseModelWithBaseURL:@"http://www.apple.com"];
    
    
}

- (void)requestActivityLoggerIsOpen:(BOOL)isOpen
{
#ifdef DEBUG
    if (isOpen) {
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    }else {
        [[AFNetworkActivityLogger sharedLogger] stopLogging];
    }
#endif
}

#pragma mark - 数据请求类

- (AFHTTPRequestOperation *)requestWithModel:(CGRequestModel *)requestModel success:(SuccessForRequestResult)success failure:(FailureForRequestResult)failure completion:(CompletionForRequestResult)completion
{
    SuccessForRequestResult successBlock = ^(AFHTTPRequestOperation *operation, id responseObject){
        if (success) {
            success(operation, responseObject);
        }
        
        if (completion) {
            completion(operation);
        }
    };
    
    FailureForRequestResult failureBlock = ^(AFHTTPRequestOperation *operation, NSError *error){
        if (failure) {
            failure(operation, error);
        }
        if (completion) {
            completion(operation);
        }
    };
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:nil];
    
    
    AFHTTPRequestOperation *operation = [self.requestOperationManager HTTPRequestOperationWithRequest:request success:successBlock failure:failureBlock];
    
    return operation;
}
@end
