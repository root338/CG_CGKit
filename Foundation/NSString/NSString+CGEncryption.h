//
//  NSString+Encryption.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/19.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (CGEncryption)

/** 哈希加密 */
- (nullable NSString*)SHA1;

/** MD5 加密 */
- (nullable NSString *)MD5String;

/** MD5 加密后转小写 */
- (nullable NSString *)MD5StringLowercase;
@end

NS_ASSUME_NONNULL_END