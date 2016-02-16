//
//  UIView+CGAddView.h
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CGAddView)

/** 
 *  当视图的bounds为CGRectZero时不添加该视图，如果存在且bounds=CGRectZero时，移除该视图 
 *  @param 返回视图是否可以添加
 */
- (BOOL)cg_addSubview:(UIView *)view;

@end
