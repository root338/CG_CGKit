//
//  CGRequestModel.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestBaseModel.h"

/** 网络请求类 */
@interface CGRequestModel : CGRequestBaseModel

#pragma mark - 请求路径
/** 请求的路径 */
@property (strong, nonatomic) NSString *pathURL;

#pragma mark - 请求数据

/** 请求的数据 */
@property (strong, nonatomic) NSDictionary *parameters;

#pragma mark - 本地处理类型
/** 解析返回对象所需要的类 */
@property (assign, nonatomic) Class resolveResponseClass;

/** 是否自动解析返回对象 */
@property (assign, nonatomic) BOOL isAutoResolveResponse;


@end
