//
//  CGRequestBaseModel.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGRequestDefineHeader.h"

NS_ASSUME_NONNULL_BEGIN
/** 网络请求的模型基类 */
@interface CGRequestBaseModel : NSObject<NSCopying>

#pragma mark - 请求连接
/** 基链接 */
@property (strong, nonatomic) NSString *baseURL;

#pragma mark - 发送方式
/** 请求HTTP的方式 */
@property (assign, nonatomic) CGHTTPRequestType HTTPRequestType;

/** POST请求下body封装的数据形式 */
@property (assign, nonatomic) CGHTTPRequestBodyType HTTPRequestBodyType;

#pragma mark - 请求数据
/** 添加的HTTP头信息 */
@property (strong, nonatomic) NSDictionary *HTTPHeaderParameters;

#pragma mark - 视图提示框显示设置
/** 是否显示提示视图 */
@property (assign, nonatomic) BOOL isShowPromptView;

/** 延迟多少秒加载提示视图 */
@property (assign, nonatomic) NSTimeInterval delayTimeInterval;

/** 加载的提示文字 */
@property (strong, nonatomic) NSString *loadingPromptString;

@end
NS_ASSUME_NONNULL_END