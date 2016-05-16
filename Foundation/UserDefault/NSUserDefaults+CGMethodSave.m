//
//  NSUserDefaults+CGMethodSave.m
//  QuickAskCommunity
//
//  Created by DY on 16/5/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "NSUserDefaults+CGMethodSave.h"
#import "NSUserDefaults+SaveData.h"
#import "NSString+CGEncryption.h"

@implementation NSUserDefaults (CGMethodSave)

+ (NSString *)methodNameKey
{
    static NSString *methodNameKey  = nil;
    if (!methodNameKey) {
        
        methodNameKey   = [@"CG_CGKit_UserDefaults_MethodSave_methodNameKey" MD5String];
//        [self removeAllSaveMethodNamesArray];
    }
    return methodNameKey;
}

+ (void)cg_addMethodNameWithChar:(const char *)methodName
{
    [self cg_addMethodNameWithString:[NSString stringWithUTF8String:methodName]];
}

+ (void)cg_addMethodNameWithString:(NSString *)methodName
{
    NSString *methodNameKey = [self methodNameKey];
    NSMutableArray *methodNamesArray  = [[NSMutableArray alloc] initWithArray:[self cg_getObjectForKey:methodNameKey]];
    [methodNamesArray insertObject:methodName atIndex:0];
    [self cg_saveWithObject:methodNamesArray forKey:methodNameKey];
    
    [self cg_saveChangeData];
}

+ (NSArray *)cg_getMethodNamesArray
{
    return [self cg_getObjectForKey:[self methodNameKey]];
}

+ (void)removeAllSaveMethodNamesArray
{
    [[self standardUserDefaults] removeObjectForKey:[self methodNameKey]];
}
@end
