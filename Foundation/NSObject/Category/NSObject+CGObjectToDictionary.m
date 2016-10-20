//
//  NSObject+CGObjectToDictionary.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+CGObjectToDictionary.h"

#import <objc/runtime.h>
#import "CGPrintLogHeader.h"

@implementation NSObject (CGObjectToDictionary)

- (NSDictionary *)cg_objectToDictionary
{
    
    return [self cg_objectToDictionaryWithTargetClass:[self class]];
}

- (NSDictionary *)cg_allObjectToDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    Class targetClass     = [self class];
    while (targetClass) {
        
        NSDictionary *targetClassPropertyDictionary = [self cg_objectToDictionaryWithTargetClass:targetClass];
        if (targetClassPropertyDictionary) {
            [dic setDictionary:targetClassPropertyDictionary];
        }
        targetClass = [targetClass superclass];
    }
    
    return dic;
}

- (nullable NSDictionary *)cg_objectToDictionaryWithTargetClass:(Class)targetClass
{
    BOOL filterTarget   = YES;
    
    id<CGObjectToDictionaryFilterDelegate> delegate    = nil;
    if ([self conformsToProtocol:@protocol(CGObjectToDictionaryFilterDelegate)]) {
        delegate    = (id<CGObjectToDictionaryFilterDelegate>)self;
    }
    
    if ([delegate respondsToSelector:@selector(cg_objectToDictionaryFilterWithClass:)]) {
        filterTarget    = [delegate cg_objectToDictionaryFilterWithClass:targetClass];
    }
    if (filterTarget) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        unsigned int propertyListCount;
        
        objc_property_t *propertysList = class_copyPropertyList(targetClass, &propertyListCount);
        
        for (int i = 0; i < propertyListCount; i++) {
            
            objc_property_t property = propertysList[i];
            
            NSString *propertyName      = [NSString stringWithUTF8String:property_getName(property)];
            
            id value                    = nil;
            
            @try {
                
                value   = [self valueForKey:propertyName];
            } @catch (NSException *exception) {
                
                CGErrorLog(@"%@", exception);
            } @finally {
                
            }
            
            if (value == nil || value == [NSNull null]) {
                continue;
            }
            
            BOOL isFlag = YES;
            if ([delegate respondsToSelector:@selector(cg_objectToDictionaryFilterWithKey:value:)]) {
                isFlag  = [delegate cg_objectToDictionaryFilterWithKey:propertyName value:value];
            }
            
            if (isFlag) {
                [dic setObject:value forKey:propertyName];
            }
        }
        
        return dic;
    }else {
        return nil;
    }
}

@end
