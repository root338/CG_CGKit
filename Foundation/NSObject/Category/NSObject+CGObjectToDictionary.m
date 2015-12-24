//
//  NSObject+CGObjectToDictionary.m
//  QuickAskCommunity
//
//  Created by DY on 15/12/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "NSObject+CGObjectToDictionary.h"

#import <objc/runtime.h>

@implementation NSObject (CGObjectToDictionary)

- (NSDictionary *)cg_objectToDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    unsigned int propertyListCount;
    
    objc_property_t *propertysList = class_copyPropertyList([self class], &propertyListCount);
    
    for (int i = 0; i < propertyListCount; i++) {
        
        objc_property_t property = propertysList[i];
        
        NSString *propertyName      = [NSString stringWithUTF8String:property_getName(property)];
        
        id value                    = [self valueForKey:propertyName];
        
        if (value == nil || value == [NSNull null]) {
            continue;
        }
        
        BOOL isFlag = [self cg_objectToDictionaryFilterWithKey:propertyName value:value];
        
        if (isFlag) {
            [dic setObject:value forKey:propertyName];
        }
    }
    
    return dic;
}

- (BOOL)cg_objectToDictionaryFilterWithKey:(NSString *)key value:(id)value
{
    return YES;
}
@end
