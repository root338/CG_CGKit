//
//  CGRequestDefineHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/7.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#ifndef QuickAskCommunity_CGRequestDefineHeader_h
#define QuickAskCommunity_CGRequestDefineHeader_h

/**
 *  HTTP的请求方式
 */
typedef NS_ENUM(NSInteger, CGHTTPRequestType){
    /**
     *  GET方式
     */
    CGHTTPRequestTypeGET,
    /**
     *  POST方式
     */
    CGHTTPRequestTypePOST,
};

/**
 *  发送的数据形式
 */
typedef NS_ENUM(NSInteger, CGHTTPRequestBodyType){
    /**
     *  json串的形式
     */
    CGHTTPRequestBodyTypeJSON,
    /**
     *  键值对的形式
     */
    CGHTTPRequestBodyTypeKey_Value,
};

/**
 *  解析类型说明
 */
typedef NS_ENUM(NSInteger, CGResolveResponseType){
    /**
     *  不解析
     */
    CGResolveResponseTypeDone,
    /**
     *  自动解析
     */
    CGResolveResponseTypeDefine,
};

#endif
