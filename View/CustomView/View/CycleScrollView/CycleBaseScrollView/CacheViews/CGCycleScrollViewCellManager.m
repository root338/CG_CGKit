//
//  CGCycleScrollViewCellManager.m
//  TestProject
//
//  Created by DY on 15/11/26.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGCycleScrollViewCellManager.h"

#import "CGCycleCellReuseObject.h"

#import "CGPrintLogHeader.h"

@interface CGCycleScrollViewCellManager ()

/** 重用存储对象 */
@property (nullable, nonatomic, strong) NSMutableDictionary<NSString *, CGCycleCellReuseObject *> *reuseDictionary;
@end

@implementation CGCycleScrollViewCellManager

#pragma mark - 创建缓存标识
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    [self registerObj:nil forCellReuseIdentifier:identifier];
}

- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    [self registerObj:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerObj:(nullable id)obj forCellReuseIdentifier:(NSString *)identifier
{
    if (obj == nil) {
        return;
    }
    CGDebugAssert(![self.reuseDictionary objectForKey:identifier], @"所设置的标识已存在");
    
    CGCycleCellReuseObject *reuseObj = [CGCycleCellReuseObject createCellReuseWithTargetObj:obj identifier:identifier];
    if (self.reuseDictionary) {
        [self.reuseDictionary setObject:reuseObj forKey:identifier];
    }else {
        self.reuseDictionary  = [NSMutableDictionary dictionaryWithObject:reuseObj forKey:identifier];
    }
}

#pragma mark - 获取cell
- (nullable __kindof CGCycleScrollViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    CGCycleCellReuseObject *cellReuseObj    = [self.reuseDictionary objectForKey:identifier];
    
    return [cellReuseObj cell];
}

- (__kindof CGCycleScrollViewCell *)cellForIndex:(NSUInteger)index
{
    return nil;
}

@end
