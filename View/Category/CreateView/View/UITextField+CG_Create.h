//
//  UITextField+CG_Create.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/* 创建文本框 */
@interface UITextField (CG_Create)

/**
 *  创建输入框
 *
 *  @param placeholder 提示文字
 */
+ (instancetype)cg_createTextFieldWithPlaceholder:(NSString *)placeholder;

@end
NS_ASSUME_NONNULL_END