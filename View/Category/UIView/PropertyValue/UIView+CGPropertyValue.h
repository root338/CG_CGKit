//
//  UIView+CGPropertyValue.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 获取非UIView直接属性的值 */
@interface UIView (CGPropertyValue)

@property (nonatomic, assign, readonly) BOOL isStatusBarHidden;

@end
