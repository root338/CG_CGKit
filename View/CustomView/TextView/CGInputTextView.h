//
//  CGInputTextView.h
//  TestProject
//
//  Created by DY on 15/12/1.
//  Copyright © 2015年 -. All rights reserved.
//

#import "CGTextView.h"

@class CGInputTextView;

/**
 *  当自动滑动时出现的错误信息
 */
typedef NS_ENUM(NSInteger, CGInputTextViewScrollFailureType) {
    /**
     *  没有错误
     */
    CGInputTextViewScrollFailureTypeNone,
    /**
     *  没有找到ScrollView视图
     */
    CGInputTextViewScrollFailureTypeNotScrollView,
    /**
     *  父视图（scrollView）的滑动区域小于需要滑动的最小值
     */
    CGInputTextViewScrollFailureTypeContentSizeLessThanNeedMinScrollValue,
    /**
     *  未知错误
     */
    CGInputTextViewScrollFailureTypeUnknown,
};

/**
 *  处理键盘通知出现的问题
 */
typedef NS_ENUM(NSInteger, CGInputTextViewNoteType) {
    /**
     *  没有问题
     */
    CGInputTextViewNoteTypeNone,
    /**
     *  没有父视图
     */
    CGInputTextViewNoteTypeNotSuperView,
    /**
     *  禁止自动处理键盘通知
     */
    CGInputTextViewNoteTypeDisableAutoHandleNotification,
    /**
     *  禁止自动处理父视图滑动
     */
    CGInputTextViewNoteTypeDisableAutoScrollSuperView,
    /**
     *  处理父视图滑动失败
     */
    CGInputTextViewNoteTypeAutoScrollSuperViewFailure,
    /**
     *  未知
     */
    CGInputTextViewNoteTypeUnknown,
};

@protocol CGInputTextViewDelegate <NSObject>

@optional

/** 
 *  视图将要在窗口中显示或移除
 */
- (void)cg_textView:(CGInputTextView *)textView willMoveToWindows:(UIWindow *)windows;

/** 是否应该自动处理该键盘通知 */
- (BOOL)cg_textView:(CGInputTextView *)textView shouldAutoHandleKeyboardNotification:(NSNotification *)note ;

/**
 *  自定处理键盘事件失败需要代理类自行实现
 *
 *  @param textView        处理事件文本框
 *  @param note            处理的通知
 *  @param noteFailureType 错误的原因
 */
- (void)cg_textView:(CGInputTextView *)textView handleKeyboardNotification:(NSNotification *)note noteFailureType:(CGInputTextViewNoteType)noteFailureType;

/**
 *  当可以自动滑动，滑动失败时回调
 *  弃用
 *  @warning 在cg_textView:handleKeyboardNotification:noteFailureType:方法之前调用
 *
 *  @param textView    处理事件文本框
 *  @param note        处理的通知
 *  @param failureType 错误的原因
 */
//- (void)cg_textView:(CGInputTextView *)textView notification:(NSNotification *)note failureType:(CGInputTextViewScrollFailureType)failureType;

/**
 *  输入的字符串大于给定的最大字数
 *
 *  @param textView 处理事件文本框
 */
- (void)cg_textViewInputWordsMoreThanMaxInputWords:(CGInputTextView *)textView;

@end

/**
 *  输入文本框
 *  @warning 文本的最大数实现原理为：
 *      默认实时判断：在UITextViewDelegate协议方法textView:shouldChangeTextInRange:replacementText:判断输入的字符串是否超出规定范围
 *      当设置isEnableDidEndEditingHandleWordsLimit为YES时，会在输入结束后才进行判断
 *      实现输入限制是本类中实现UITextViewDelegate协议，当自行设置delegate属性后，输入限制会无效
 *
 *  实现的功能：
 *
 *
 *  问题：
 *  1. 滑动父视图有问题，(测试，表格中添加该view)
 */

@interface CGInputTextView : CGTextView<UITextViewDelegate>

@property (weak, nonatomic) id<CGInputTextViewDelegate> cg_delegate;

/** 是否自动处理键盘通知事件 默认为YES*/
@property (assign, nonatomic) BOOL isAutoHandleKeyboardNotification;

#pragma mark - 键盘通知、视图移动相关
/** 是否可以自动处理父视图的scrollview 默认为YES */
@property (assign, nonatomic) BOOL isAutoScrollingSuperView;

/** 最低的可视区域高度，默认为minHeight */
@property (assign, nonatomic) CGFloat minVisibleHeight;

/** 移动父视图scrollView（若存在）时，是否执行动画 默认为NO */
@property (assign, nonatomic) BOOL isAnmiationContentOffset;

/** 在可选条件下优先滑动父视图 默认为NO */
@property (assign, nonatomic) BOOL priorityScrollSuperView;

/** 处理滑动视图时的错误类型 */
@property (assign, nonatomic, readonly) CGInputTextViewScrollFailureType handleScrollFailureType;

#pragma mark - 限定输入
/**
 *  当自行设置该类的delegate属性后，限定输入会失去功能
 */

/** 是否开启在编辑结束时才判断字数限制 */
@property (assign, nonatomic) BOOL isEnableDidEndEditingHandleWordsLimit;

/** 最大可输入的字数 */
@property (assign, nonatomic) NSUInteger maxInputWords;

/** 输入字符不大于最大字数 */
@property (assign, nonatomic, readonly) BOOL isInputTextNotMoreThanMaxWords;

/** 处理键盘通知事件 */
- (void)handleKeyboardNotification:(NSNotification *)note;
@end
