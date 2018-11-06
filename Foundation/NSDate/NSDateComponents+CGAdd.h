//
//  NSDateComponents+CGAdd.h
//  QuickAskCommunity
//
//  Created by apple on 2018/11/5.
//  Copyright © 2018 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CGDateDefineConstantsHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSDateComponents (CGAdd)

+ (instancetype)createDateComponentsWithFormatterString:(NSString *)formatterString style:(CGFormatterStyle)style;

@end

NS_ASSUME_NONNULL_END
