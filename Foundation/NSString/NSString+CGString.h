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

@end
NS_ASSUME_NONNULL_END