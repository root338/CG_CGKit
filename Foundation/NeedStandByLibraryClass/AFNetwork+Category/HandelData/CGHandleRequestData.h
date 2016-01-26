//
//  CGHandleRequestData.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/9.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGRequestDefineHeader.h"

NS_ASSUME_NONNULL_BEGIN
/** 数据解析类 */
@interface CGHandleRequestData : NSObject

/** 解析返回对象所需要的类，@warning 必须为JSONModel的子类 */
@property (assign, nonatomic) Class resolveResponseClass;

/** 是否自动解析返回对象 */
@property (assign, nonatomic) CGResolveResponseType isAutoResolveResponse;

/** 传入的解析类 */
@property (strong, nonatomic) id responseObject;

/**
 *  创建解析类
 *
 *  @param responseObject        返回的对象
 *  @param isAutoResolveResponse 是否自动解析返回对象
 *  @param resolveResponseClass  解析返回对象所需要的类
 *  @warning 解析类必须为JSONModel的子类
 *
 *  @return 返回创建好的解析类
 */
+ (instancetype)createResolveWithObject:(id)responseObject isAutoResolveResponse:(BOOL)isAutoResolveResponse resolveResponseClass:(Class)resolveResponseClass;

/**
 *  初始化解析类
 *
 *  @param responseObject        返回的对象
 *  @param isAutoResolveResponse 是否自动解析返回对象
 *  @param resolveResponseClass  解析返回对象所需要的类
 *  @warning 解析类必须为JSONModel的子类
 *
 *  @return 返回创建好的解析类
 */
- (instancetype)initWithObject:(id)responseObject isAutoResolveResponse:(BOOL)isAutoResolveResponse resolveResponseClass:(Class)resolveResponseClass;
@end
NS_ASSUME_NONNULL_END