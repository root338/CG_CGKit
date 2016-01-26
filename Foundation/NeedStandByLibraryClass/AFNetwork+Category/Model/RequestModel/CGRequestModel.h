//
//  CGRequestModel.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGRequestBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
/** 网络请求类 */
@interface CGRequestModel : CGRequestBaseModel

#pragma mark - 请求路径
/** 请求的路径 */
@property (strong, nonatomic) NSString *pathURL;

#pragma mark - 请求数据

/** 请求的数据 */
@property (strong, nonatomic) NSDictionary *parameters;

#pragma mark - 本地处理类型
/** 解析返回对象所需要的类，必须为JSONModel的子类 */
@property (assign, nonatomic) Class resolveResponseClass;

/** 是否自动解析返回对象 */
@property (assign, nonatomic) CGResolveResponseType isAutoResolveResponse;

#pragma mark - 父类值变量判断标识

/** 是否应用设置的body发送的形式 */
@property (assign, nonatomic) BOOL isApplyHTTPRequestBodyType;

/** 是否应用设置的请求的HTTP的方式 */
@property (assign, nonatomic) BOOL isApplyHTTPRequestType;

#pragma mark - 视图提示框显示设置
@property (assign, nonatomic) BOOL isApplyShowPromptView;

@end

NS_ASSUME_NONNULL_END