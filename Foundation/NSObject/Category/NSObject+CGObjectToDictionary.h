//
//  NSObject+CGObjectToDictionary.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/** 对象转字典 */
@interface NSObject (CGObjectToDictionary)

/** 
 *  对象转字典主体方法
 *  @param 自动过滤掉nil值和 NSNull对象
 */
- (nullable NSDictionary *)cg_objectToDictionary;

/**
 *  转换过程中的过滤方法
 *  @warning 子类可以重写该方法过滤不必要的key值
 *
 *  @param key   对象的属性名称
 *  @param value 相对属性名的值
 *
 *  @return 返回是否添加该key值 YES（添加）
 */
- (BOOL)cg_objectToDictionaryFilterWithKey:(NSString *)key value:(id)value;
@end

NS_ASSUME_NONNULL_END