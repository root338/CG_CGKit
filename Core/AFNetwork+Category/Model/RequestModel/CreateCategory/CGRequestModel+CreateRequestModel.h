//
//  CGRequestModel+CreateRequestModel.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestModel.h"

/** 创建网络请求类 */
@interface CGRequestModel (CreateRequestModel)

/**
 *  创建网络请求类，包含（请求路径，封装参数，返回数据解析类）参数
 *
 *  @param pathURL              请求路径
 *  @param parameters           封装参数
 *  @param resolveResponseClass 返回数据解析类
 *
 *  @return 返回创建好的请求类
 */
+ (instancetype)createRequestModelWithPathURL:(NSString *)pathURL parameters:(NSDictionary *)parameters resolveResponseClass:(Class)resolveResponseClass;

@end
