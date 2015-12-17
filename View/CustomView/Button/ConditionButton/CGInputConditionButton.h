//
//  CGInputConditionButton.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseButton.h"

@protocol CGInputConditionButtonDelegate <NSObject>

@optional


@end

/**
 *  对输入文本框进行输入监听，当输入的条件不满足时按钮为disable状态
 *  @param 只对输入内容是否为空来进行判断，其他条件可实现代理方法的判断
 */
@interface CGInputConditionButton : CGBaseButton

/** 需要判断的输入文本集合 */
@property (nonatomic, strong) NSArray *inputControls;


@end
