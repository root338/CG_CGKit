//
//  CGInputConditionButton.h
//  TestCG_CGKit
//
//  Created by DY on 15/12/16.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseButton.h"

//@protocol CGInputConditionButtonDelegate <NSObject>
//
//@optional
//
//
//@end

/**
 *  对输入文本框进行输入监听，当输入的条件不满足时按钮为disable状态
 *  @param 默认只对是否为空进行判断，其它判断在textDidChangeCallback中进行（inputTextView 表示当前文本正在改变的输入文本框）
 *  @warning 若直接设置输入文本框的text属性，UITextFieldTextDidChangeNotification通知是收不到消息的！！！
 */
@interface CGInputConditionButton : CGBaseButton

/** 需要判断的输入文本集合(只能是UITextField，UITextView类型) */
@property (nonatomic, strong) NSArray *inputControls;

/** 是否开启UITextfield文本变化通知，需要手动开启 */
@property (nonatomic, assign) BOOL isOpenTextFieldDidChangeNotification;
/** 是否开启UITextView文本变化通知，需要手动开启 */
@property (nonatomic, assign) BOOL isOpenTextViewDidChangeNotification;

/** 文本发生变化时的回调，返回按钮是否可以点击 */
@property (nonatomic, copy) BOOL (^textDidChangeCallback) (id inputTextView);

- (void)updateVerifyAllInputControl;
- (void)updateVerifyWithTargetInputControl:(id)inputControl;
@end
