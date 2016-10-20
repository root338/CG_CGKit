//
//  NSObject+CGObjectToDictionary.h
//  QuickAskCommunity
//
//  Created by DY on 15/12/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 转换的过滤方法 */
@protocol CGObjectToDictionaryFilterDelegate <NSObject>

@optional
/**
 *  转换过程中的过滤不必要的key值方法
 *
 *  @param key   对象的属性名称
 *  @param value 相对属性名的值
 *
 *  @return 返回是否添加该key值 YES（添加）
 */
- (BOOL)cg_objectToDictionaryFilterWithKey:(NSString *)key value:(id)value;

/**
 *  转换过程中的过滤方法，当前类下的属性是否需要添加到字典中
 *
 *  @param targetClass  对象类的名称
 *
 *  @return 返回是否添加该key值 YES（添加）
 */
- (BOOL)cg_objectToDictionaryFilterWithClass:(Class)targetClass;

@end

/** 对象转字典 */
@interface NSObject (CGObjectToDictionary)

/** 
 *  对象转字典主体方法
 *  @param 自动过滤掉nil值和 NSNull对象
 *  @warning    仅会将当前类的属性值转化为字典，父类属性不包含
 */
- (nullable NSDictionary *)cg_objectToDictionary;

- (nullable NSDictionary *)cg_objectToDictionaryWithTargetClass:(Class)targetClass;

/**
 *  对象转字典主体方法
 *  @param 自动过滤掉nil值和 NSNull对象
 */
- (nullable NSDictionary *)cg_allObjectToDictionary;

@end

NS_ASSUME_NONNULL_END
