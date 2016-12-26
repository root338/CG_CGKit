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


NS_ASSUME_NONNULL_BEGIN

/**
 *  对输入文本框进行输入监听，当输入的条件不满足时按钮为disable状态
 *  @param 默认只对是否为空进行判断，其它判断在textDidChangeCallback中进行（inputTextView 表示当前文本正在改变的输入文本框）
 *  @warning 若直接设置输入文本框的text属性，UITextFieldTextDidChangeNotification通知是收不到消息的！！！
 */
@interface CGInputConditionButton : CGBaseButton

/** 需要判断的输入文本集合(只能是UITextField，UITextView类型) */
@property (nullable, nonatomic, strong) NSArray *inputControls;

/** 是否开启UITextfield文本变化通知，需要手动开启 */
@property (nonatomic, assign) BOOL isOpenTextFieldDidChangeNotification;
/** 是否开启UITextView文本变化通知，需要手动开启 */
@property (nonatomic, assign) BOOL isOpenTextViewDidChangeNotification;

/** 是否关闭移除首尾空白字符，默认NO */
@property (nonatomic, assign) BOOL disableRemoveWhitespaceAndNewlineCharacterSet;

/** 关闭 输入文字改变时循环属性inputControls所有变量来设置按钮状态，默认NO */
@property (nonatomic, assign) BOOL disableDidChangeTextRunLoopAllInputControls;

/** 文本发生变化时的回调，返回按钮是否可以点击 */
@property (nullable, nonatomic, copy) BOOL (^textDidChangeCallback) (id inputTextView);

/** 文本发生变化时的回调，返回按钮是否可以点击 */
@property (nullable, nonatomic, copy) BOOL (^inputControlDidTextChangeCallback) (id inputTextView, NSString *inputText);

- (void)updateVerifyAllInputControl;
- (BOOL)updateVerifyWithTargetInputControl:(id)inputControl;
@end

NS_ASSUME_NONNULL_END
