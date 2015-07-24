//
//  CGTextFieldInputView.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  文本输入框输入视图的类型
 */
typedef NS_ENUM(NSInteger, CGTextFieldInputViewType){
    /**
     *  普通的取消、完成视图
     */
    CGTextFieldInputViewTypeDefalut,
    /**
     *  带切换按钮的完成视图，左右箭头 + 完成
     */
    CGTextFieldInputViewTypeSwitch
};

/**
 *  文本输入框输入视图上按钮的样式
 */
typedef NS_ENUM(NSInteger, CGTextFieldInputButtonType){
    /**
     *  取消
     */
    CGTextFieldInputButtonTypeCancel = -1,
    /**
     *  完成
     */
    CGTextFieldInputButtonTypeCarryOut,
    /**
     *  左箭头
     */
    CGTextFieldInputButtonTypeLeftArrow,
    /**
     *  右箭头
     */
    CGTextFieldInputButtonTypeRightArrow,
};

typedef UIButton *(^SetupInputViewInButton)(CGTextFieldInputButtonType buttonType);

@protocol CGTextFieldInputViewDelegate <NSObject>

/**
 *  文本输入框 inputView 上按钮触发的回调方法
 *
 *  @param inputView UITextField 的 inputView
 *  @param type      inputView 中按钮类型
 */
- (void)textFieldInputView:(CGTextFieldInputViewType *)inputView buttonType:(CGTextFieldInputButtonType)type;

@end

@interface CGTextFieldInputView : UIView

+ (instancetype)createTextFieldInputView:(CGTextFieldInputViewType)viewType;

@property (weak, nonatomic) id<CGTextFieldInputViewDelegate> delegate;

@property (copy, nonatomic) SetupInputViewInButton setupInputViewInSubview;
@end
