//
//  NSPredicate+CreatePredicate.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/12.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSPredicate (CreatePredicate)

+ (instancetype)createPredicateSelfMatchesWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END