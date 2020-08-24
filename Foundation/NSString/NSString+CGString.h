//
//  NSString+CGString.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GMLAddStringIgnore) {
    /// 忽略空
    GMLAddStringIgnoreNull = 1 << 0,
    /// 忽略首尾空白字符和换行
    GMLAddStringIgnoreWhitespaceAndNewline = 1 << 1,
    GMLAddStringIgnoreAll = GMLAddStringIgnoreNull | GMLAddStringIgnoreWhitespaceAndNewline,
};

@protocol GMLAddStringProtocol <NSObject>
/// 获取的值，默认 GMLAddStringIgnoreAll
@property (nonatomic, assign) GMLAddStringIgnore cg_ignoreValue;
@property (nullable, nonatomic, copy) NSString * (^cg_willAppendStringHandle) (NSString *willAppendString);
@property (nonatomic, copy, readonly) id<GMLAddStringProtocol> (^cg_appendString) (NSString *);
- (id<GMLAddStringProtocol>)cg_appendString:(NSString *)string;
@end

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

+ (NSMutableString *)cg_stringComponentsJoinedByString:(NSString *)separator usingBlock:(void(NS_NOESCAPE^) (id<GMLAddStringProtocol> mString))usingBlock;

- (void)removeLastString;



@end

NS_ASSUME_NONNULL_END
