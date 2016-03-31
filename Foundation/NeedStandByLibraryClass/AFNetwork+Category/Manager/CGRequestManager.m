//
//  CGRequestManager.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "CGRequestModel+Category.h"
#import "CGRequestBaseModel+Category.h"

#if DEBUG
//仅需要在debug下导入的头文件

#import "AFNetworkActivityLogger.h"

#endif

@interface CGRequestManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

#pragma mark - 网络请求数据
@property (strong, nonatomic) CGRequestBaseModel *requestBaseModel;

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
        
//        [self performSelector:@selector(initialization) withObject:nil afterDelay:0];
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
    self.requestBaseModel.HTTPRequestBodyType = CGHTTPRequestBodyTypeKey_Value;
    
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

#pragma mark - 请求内容设置

/**
 *  设置request的规则
 *
 *  @param bodyType       HTTP请求的方式
 *  @param headerIsChange 头信息是否改变
 */
- (void)setupRequestSerializerWithType:(CGHTTPRequestBodyType)bodyType headerIsChange:(BOOL)headerIsChange
{
    AFHTTPRequestSerializer *requestSerializer = nil;
    if (bodyType == CGHTTPRequestBodyTypeJSON) {
        
        if (![self.requestOperationManager.requestSerializer isKindOfClass:[AFJSONRequestSerializer class]] || headerIsChange) {
            
            requestSerializer = [AFJSONRequestSerializer serializer];
        }
    }else if (bodyType == CGHTTPRequestBodyTypeKey_Value) {
        if (![self.requestOperationManager.requestSerializer isKindOfClass:[AFHTTPRequestSerializer class]] || headerIsChange) {
            
            requestSerializer = [AFHTTPRequestSerializer serializer];
        }
    }
    
    if (requestSerializer) {
        self.requestOperationManager.requestSerializer = requestSerializer;
    }
}

- (NSString *)httpRequestMethodWithType:(CGHTTPRequestType)requestType
{
    NSString *httpMethod = nil;
    switch (requestType) {
        case CGHTTPRequestTypeGET:
            httpMethod = @"GET";
            break;
        case CGHTTPRequestTypePOST:
            httpMethod = @"POST";
            break;
        default:
            break;
    }
    
    NSAssert(httpMethod, @"HTTP请求的方式未确定， -_-!!!");
    
    return httpMethod;
}


#pragma mark - 数据请求类

- (AFHTTPRequestOperation *)requestWithModel:(CGRequestModel *)requestModel success:(SuccessForRequestResult)success failure:(FailureForRequestResult)failure completion:(CompletionForRequestResult)completion
{
    NSAssert(requestModel, @"确定不需要参数传入？");
    
    //设置请求参数
    CGRequestModel *newRequestModel = [requestModel requestWithUpdateBaseModel:self.requestBaseModel];
    
    NSMutableURLRequest *request = nil;
    
    //更新ReqeustSerializer变量
    [self setupRequestSerializerWithType:self.requestBaseModel.HTTPRequestBodyType headerIsChange:requestModel.HTTPHeaderParameters ? YES : NO];
    
    
    AFHTTPRequestSerializer *serializer = self.requestOperationManager.requestSerializer;
    
    //更新HTTP头
    if (requestModel.HTTPHeaderParameters) {
        [newRequestModel.HTTPHeaderParameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSString * obj, BOOL *stop) {
            [serializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    
    //创建请求对象
    NSString *httpMethod = [self httpRequestMethodWithType:newRequestModel.HTTPRequestType];
    
    NSError *error = nil;
    request = [serializer requestWithMethod:httpMethod
                                       URLString:newRequestModel.pathURL
                                      parameters:newRequestModel.parameters
                                           error:&error];
    NSAssert1(!error, @"创建请求对象出错 %@", error);
    
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
    
    AFHTTPRequestOperation *operation = [self.requestOperationManager HTTPRequestOperationWithRequest:request
                                                                                              success:successBlock failure:failureBlock];
    [self.requestOperationManager.operationQueue addOperation:operation];
    
    return operation;
}
@end
