//
//  NSObject+CGExchangeSelector.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (CGExchangeSelector)

/** 交换两个实例方法方法  */
+ (void)cg_exchangeInstanceMethodWithOriginalselector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
NS_ASSUME_NONNULL_END