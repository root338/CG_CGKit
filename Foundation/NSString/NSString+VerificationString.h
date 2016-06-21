//
//  NSString+VerificationString.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/9.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (VerificationString)

/** 验证字符串前缀是否是 http:// 或 https:// 开头的 */
- (BOOL)verificationIsHTTPPrefix;

/** 验证字符串是否由纯数字组成 */
- (BOOL)verificationIsAllNumber;

/** 验证字符串是否有指定位数的数字组成 */
- (BOOL)verifyNumberWithCount:(NSInteger)count;

/** 验证字符串是否是中文字符 */
- (BOOL)verificationIsChineseCharacter;

/** 验证字符串是否是手机号 */
//- (BOOL)verificationIsPhone;

@end
NS_ASSUME_NONNULL_END