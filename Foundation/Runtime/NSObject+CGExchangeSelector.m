//
//  NSObject+CGExchangeSelector.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSObject+CGExchangeSelector.h"
#import <objc/runtime.h>

@implementation NSObject (CGExchangeSelector)

+ (void)cg_exchangeInstanceMethodWithOriginalselector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Class class = [self class];
    
    Method originalMethod   =   class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod   =   class_getInstanceMethod(class, swizzledSelector);
    
    BOOL success    = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
