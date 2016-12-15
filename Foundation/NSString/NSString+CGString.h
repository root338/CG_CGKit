//
//  NSString+CGString.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSString (CGString)

- (nullable NSString *)cg_stringByAppendingString:(NSString *)aString;

- (nullable NSString *)cg_stringIgnoreWhitespaceAndNewlineCharacterSet;

- (nullable NSString *)cg_stringIgnoreWhitespaceCharacterSet;

/*! 删除最后一个字符 */
- (nullable NSString *)cg_removeLastString;

/** 去除单词之间多余的空格 */
- (nullable NSString *)cg_stringRemovalRedundantWhitespace;
@end

@interface NSMutableString (CGMutableString)

- (void)removeLastString;

@end

NS_ASSUME_NONNULL_END
