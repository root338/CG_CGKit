//
//  NSError+CGCreateError.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/19.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (CGCreateError)

/** 创建错误信息 */
+ (NSError *)cg_CreateWithCode:(NSInteger)code errorMessage:(NSString *)errorMessage;

/** 创建只有错误信息(code = -1) */
+ (NSError *)cg_CreateWithErrorMessage:(NSString *)errorMessage;
@end
