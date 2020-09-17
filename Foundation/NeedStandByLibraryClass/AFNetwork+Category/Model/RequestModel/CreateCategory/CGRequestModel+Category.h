//
//  CGRequestModel+CreateRequestModel.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestModel.h"

NS_ASSUME_NONNULL_BEGIN
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

@interface CGRequestModel (NewUpdateRequestModel)

/**
 *  合并基类请求类型
 *
 *  @param baseRequestModel 基类请求类型
 *
 *  @return 返回合并后新的请求模型
 */
- (nullable CGRequestModel *)requestWithUpdateBaseModel:(CGRequestBaseModel *)baseRequestModel;

@end
NS_ASSUME_NONNULL_END
