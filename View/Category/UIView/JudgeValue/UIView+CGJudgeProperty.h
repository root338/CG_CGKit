//
//  UIView+CGJudgeProperty.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 对UIView及其子视图一些属性的判断 */
@interface UIView (CGJudgeProperty)

#pragma mark - 显示区域判断
/** 判断UIView是否有显示区域 */
- (BOOL)cg_judgeViewSizeIsZero;


@end
NS_ASSUME_NONNULL_END