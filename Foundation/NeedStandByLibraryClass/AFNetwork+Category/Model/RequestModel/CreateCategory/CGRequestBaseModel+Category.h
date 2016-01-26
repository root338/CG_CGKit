//
//  CGRequestBaseModel+CreateRequestBaseModel.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/** 创建网络请求基类 */
@interface CGRequestBaseModel (CreateRequestBaseModel)

/**
 *  创建网络请求基类，包含（基链接）参数
 *
 *  @param baseUrl 请求的基链接
 *
 *  @return 返回创建的网络请求基类
 */
+ (instancetype)createRequestBaseModelWithBaseURL:(NSString *)baseUrl;

@end

NS_ASSUME_NONNULL_END