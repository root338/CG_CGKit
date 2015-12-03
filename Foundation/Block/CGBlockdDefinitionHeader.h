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

#pragma mark - 有返回类型，无参数

typedef id      (^cg_getTargetObject)               (void);

#pragma mark - 有返回类型，有参数

/** 提起目标对象中的特定字符串属性 */
typedef id      (^cg_getSingleValueForTargetObject) (id obj);

/** 根据父视图设置子视图的坐标 */
typedef CGRect  (^cg_setupViewRectToSuperview)      (CGRect superviewFrame, UIView *targetView);

#pragma mark - 无返回类型，有参数
/** 回调一个数值 */
typedef void    (^cg_singleValueCallback)           (NSInteger index);

/** 回调一个CGSize值 */
typedef void    (^cg_singleCGSizeCallback)          (CGSize size);

typedef void    (^cg_singleCGPointCallback)         (CGPoint point);

/** 回调一个对象 */
typedef void    (^cg_singleObjectCallback)          (id obj);

#pragma mark - 无返回类型，无参数
/** 回调block */
typedef void    (^cg_voidCallback)                  (void);

#endif /* CGBlockdDefinitionHeader_h */
