//
//  CGBlockdDefinitionHeader.h
//  QuickAskCommunity
//
//  Created by DY on 15/11/27.
//  Copyright © 2015年 ym. All rights reserved.
//

#ifndef CGBlockdDefinitionHeader_h
#define CGBlockdDefinitionHeader_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - 有返回类型
/** 提起目标对象中的特定字符串属性 */
typedef id (^cg_getSingleValueForTargetObject) (id obj);

#pragma mark - 无返回类型
/** 回调一个数值 */
typedef void (^cg_singleValueCallback) (NSInteger index);

#endif /* CGBlockdDefinitionHeader_h */
