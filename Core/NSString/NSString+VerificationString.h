//
//  NSString+VerificationString.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/9.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VerificationString)

/** 验证字符串前缀是否是 http:// 或 https:// 开头的 */
- (BOOL)verificationIsHTTPPrefix;

/** 验证字符串是否由纯数字组成 */
- (BOOL)verificationIsAllNumber;
@end
