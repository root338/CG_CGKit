//
//  NSObject+CGGetPrivateAPI.m
//  TestCG_CGKit
//
//  Created by DY on 16/1/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NSObject+CGGetPrivateAPI.h"
#import <objc/runtime.h>

#import "CGPrintLogHeader.h"

@implementation NSObject (CGGetPrivateAPI)

- (void)cg_printAllMethoh
{

}

- (NSArray *)cg_getMethodsWithClassName:(id)className
{
    unsigned int outCount;
    
    Method *methodList      = class_copyMethodList(className, &outCount);
    NSMutableArray *SELList = [NSMutableArray arrayWithCapacity:outCount];
    
    for (int index = 0; index < outCount; index++) {
        
        Method method       = methodList[index];
        SEL selectorName    = method_getName(method);
        [SELList addObject:NSStringFromSelector(selectorName)];
    }
    return SELList;
}

- (NSArray *)cg_getPropertyWithClassName:(id)className
{
    unsigned int outCount;
    objc_property_t *propertyList   = class_copyPropertyList(className, &outCount);
    
    NSMutableArray *propertyArray   = [NSMutableArray arrayWithCapacity:outCount];
    
    for (unsigned int index = 0; index < outCount; index++) {
        
        objc_property_t property_t  = propertyList[index];
        const char *propertyName    = property_getName(property_t);
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    return propertyArray;
}

- (void)cg_printAllWithType:(CGPrintLogType)type
{
#if DEBUG
    NSString *className     = NSStringFromClass([self class]);
    const char *c_calssName = [className UTF8String];
    id obj_calssName        = objc_getClass(c_calssName);
    
    CGTitleConditionLog("类型", YES, @"%@", self.description);
    
    if (type & CGPrintLogTypeProperty) {
        CGTitleConditionLog("所有的属性", YES, @"%@", [self cg_getPropertyWithClassName:obj_calssName]);
    }
    
    if (type & CGPrintLogTypeMethod) {
        CGTitleConditionLog("所有的方法", YES, @"%@", [self cg_getMethodsWithClassName:obj_calssName]);
    }
    
#endif
}


@end
