//
//  CGTextFieldInputView.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  文本输入框输入视图上按钮的样式
 */
typedef NS_ENUM(NSInteger, CGInputAccessoryViewButtonType){
    /** 完成 */
    CGInputAccessoryViewButtonTypeCarryOut,
    /** 左箭头 */
    CGInputAccessoryViewButtonTypeLeftArrow,
    /** 右箭头 */
    CGInputAccessoryViewButtonTypeRightArrow,
};

@protocol CGInputAccessoryViewDelegate <NSObject>

/**
 *  文本输入框 inputView 上按钮触发的回调方法
 *
 *  @param type      inputView 中按钮类型
 */
- (void)inputAccessoryViewWithButtonType:(CGInputAccessoryViewButtonType)type;

@end

@interface CGInputAccessoryView : UIView

@property (weak, nonatomic) id<CGInputAccessoryViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIButton *leftArrowButton;
@property (nonatomic, strong, readonly) UIButton *rightArrowButton;
@property (nonatomic, strong, readonly) UIButton *finishButton;

@end

NS_ASSUME_NONNULL_END
