//
//  CGKeyboardManager.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGKeyboardManagerHeader.h"

@import UIKit;
NS_ASSUME_NONNULL_BEGIN

/** 计算约束常量值时的方式 */
typedef NS_ENUM(NSInteger, CGKeyboardConstraintConstantType) {
    
    /** 减去获取的常量值 */
    CGKeyboardConstraintConstantTypeLess,
    /** 增加获取的常量值 */
    CGKeyboardConstraintConstantTypeAdd,
};

@class CGKeyboardManager;

@protocol CGKeyboardManagerDelegate <NSObject>

@optional
#pragma mark - 自定义处理键盘通知
/** 是否应该处理该键盘通知 @warning 当返回NO时，将不会执行之后的操作 */
- (BOOL)keyboardManager:(CGKeyboardManager *)keyboardManager shouldDealWithNotification:(NSNotification *)note;

/** 键盘显示时通知的回调 */
- (void)keyboardManager:(CGKeyboardManager *)keyboardManager showKeyboardNotification:(NSNotification *)note;
/** keyboardManager:showKeyboardNotification:代理方法执行过后是否继续向下执行 */
- (BOOL)keyboardManager:(CGKeyboardManager *)keyboardManager didShowKeyboardDealWithNotification:(NSNotification *)note;

/** 键盘隐藏时通知的回调 */
- (void)keyboardManager:(CGKeyboardManager *)keyboardManager hideKeyboardNotification:(NSNotification *)note;
/** keyboardManager:hideKeyboardNotification:代理方法执行过后是否继续向下执行 */
- (BOOL)keyboardManager:(CGKeyboardManager *)keyboardManager didHideKeyboardDealWithNotification:(NSNotification *)note;

#pragma mark - 返回键盘的一些参数

/** 执行动画时设置的回调 */
- (void)keyboardManager:(CGKeyboardManager *)keyboardManager animationsNotification:(NSNotification *)note;
/** 动画执行完毕的回调 */
- (void)keyboardManager:(CGKeyboardManager *)keyboardManager animationCompletionNotification:(NSNotification *)note;

#pragma mark - 不使用默认设置，直接设置参数代理
//-----设置视图--------------------------------
/** 
 *  设置第一响应者
 *  不使用属性firstResponderView
 */
- (nullable UIView *)firstResponderViewWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification;

/** 
 *  设置第一响应者所在的滑动视图
 *  和属性scrollView一样
 */
- (nullable UIScrollView *)scrollViewWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification;

/** 
 *  设置需要改变frame的视图
 *  和属性keyboardFrameDidChangeTheNeedToChangeFrameTheView一样，表示当弹起或隐藏键盘时需要改变的视图frame
 */
- (UIView *)needChangeFrameTheViewWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification;


//-----设置显示区域------------------------------

/**
 *  设置keyboardFrameDidChangeTheNeedToChangeFrameTheView 的显示区域
 *  @param  keyboardRect            键盘的显示区域
 *  @param  needChangeFrameTheView  需要改变frame的视图
 *  @return  返回keyboardFrameDidChangeNeedView的显示区域
 */
- (CGRect)targetViewFrameWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification keyboardRect:(CGRect)keyboardRect needChangeFrameTheView:(UIView *)needChangeFrameTheView;

//-----约束相关---------------------------------

/**
 *  设置 keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint constant的值
 *  @param  keyboardRect            键盘的显示区域
 *  @param  needChangeFrameTheView  需要改变frame的视图
 *  @return  返回keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint constant的值
 */
- (CGFloat)targetViewBottomConstraintConstantWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification keyboardRect:(CGRect)keyboardRect needChangeFrameTheView:(UIView *)needChangeFrameTheView;

/** 
 *  设置目标的约束
 *  和属性keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint一样
 */
- (NSLayoutConstraint *)targetViewBottomConstraintWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification needChangeFrameTheView:(nullable UIView *)needChangeFrameTheView;

/** 
 *  使用约束时返回偏移的距离
 *  @param constant 偏移的距离
 */
//- (void)keyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification constant:(CGFloat)constant;

//-----设置输入视图------------------------------
- (BOOL)keyboardManager:(CGKeyboardManager *)keyboardManager shouldScrollingWithTextField:(UITextField *)textField;
//- (BOOL)keyboardManager:(CGKeyboardManager *)keyboardManager shouldScrollingWithTextView:(UITextView *)textView;

//-----计算键盘与需要改变显示区域的视图之间的重复区域------------------------------
/** 
 *  设置此视图来计算键盘在其上的显示区域，和需要改变视图在其上的显示区域。来获取是否有覆盖且覆盖多少距离 
 *  默认使用needChangeFrameTheView的父视图
 */
- (UIView *)overlayViewWithKeyboardManager:(CGKeyboardManager *)keyboardManager needChangeFrameTheView:(UIView *)needChangeFrameTheView;

/** 
 *  自动布局改变frame时，以哪种方式来改变frame 
 *  和keyboardChangeFrameType属性值功能一样
 */
- (CGKeyboardChangeFrameType)changeFrameTypeWithKeyboardManager:(CGKeyboardManager *)keyboardManager needChangeFrameTheView:(UIView *)needChangeFrameTheView;

/** 由于约束的第一个对象的边与第二个对象的边的不同对常量的加减也不相同，所以需要指定计算的常量值如何设置 */
//- (CGKeyboardConstraintConstantType)keyboardManager:(CGKeyboardManager *)keyboardManager targetConstraint:(NSLayoutConstraint *)constraint constantSpace:(CGFloat)constantSpace;

/// 即将设置视图frame时，给予最后的修正
/// @param frame 即将设置的frame
- (CGRect)keyboardManager:(CGKeyboardManager *)keyboardManager willSetFrame:(CGRect)frame;
@end

/** 
 *  键盘通知管理
 *  管理当键盘弹入或弹出时改变视图frame，并将第一响应者滑动到可视区域
 *  简单使用
 *              1.使用约束时，开启键盘键盘将要弹入弹出通知 openKeyboardWillNotification;
 *              设置keyboardFrameDidChangeTheNeedToChangeFrameTheView 属性值
 *              设置keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint 属性值
 */
@interface CGKeyboardManager : NSObject

#pragma mark - 键盘通知
/** 开启UIKeyboardWillHideNotification, UIKeyboardWillShowNotification键盘通知 */
@property (nonatomic, assign) BOOL openKeyboardWillNotification;
/** 开启UIKeyboardDidHideNotification， UIKeyboardDidShowNotification键盘通知 */
@property (nonatomic, assign) BOOL openKeyboardDidNotification;

/** 开启其它键盘通知 */
- (void)addKeyboardNotificationName:(NSArray<NSString *> *)keyboardNotificationNameArray target:(id)target selector:(SEL)selector object:(nullable id)object;
/** 关闭其它键盘通知 @warning 应该与addKeyboardNotificationName:方法配对使用 */
- (void)removeKeyboardNotificationName:(NSArray<NSString *> *)keyboardNotificationNameArray target:(id)target object:(nullable id)object;

#pragma mark - 改变视图
/**
    !当设置delegate时，并实现自定义键盘显示／隐藏方法时，且不向下进行处理，设置的scrollView不进行处理
 */

/** 处理的类型以自动布局或AutoLayout进行处理 
 ＊  @warning 自动处理原理当设置约束时优先处理约束，否则处理自动布局
 */
//@property (nonatomic, assign) CGKeyboardLayoutType keyboardLayoutType;

/** 当有键盘通知改变视图大小时改变其滑动视图contentOffset */
@property (nullable, nonatomic, weak) UIScrollView *scrollView;
/** 第一响应者 */
@property (nullable, nonatomic, weak) UIView *firstResponderView;

/** 是否隐藏滑动动画 */
@property (nonatomic, assign) BOOL hideScrollAnimated;
/** 
 *  禁止自动搜索滑动视图
 *  当第一响应者不为nil且scrollView为空时，当为 NO 时，自动尝试搜索第一响应者的父视图中是否存在scrollView，当存在时执行滑动，默认为NO
 */
@property (nonatomic, assign) BOOL disableAutoSearchScrollView;

/** 当第一响应者为UITextView时是否自动滑动，默认 NO */
@property (nonatomic, assign) BOOL enableFirstResponderIsUITextViewAutoScrolling;

/** 键盘显示区域发生改变时需要改变的view  @warning 改变该视图的显示区域 */
@property (nullable, nonatomic, weak) UIView *keyboardFrameDidChangeTheNeedToChangeFrameTheView;
/** 键盘显示区域发生改变时需要改变的view的底部约束  @warning 改变该视图的显示区域 */
@property (nullable, nonatomic, weak) NSLayoutConstraint *keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint;

/** 修改frame的类型 默认为CGKeyboardChangeFrameTypeSize */
@property (nonatomic, assign) CGKeyboardChangeFrameType keyboardChangeFrameType;

/** 计算的常量值计算的方式 */
@property (nonatomic, assign) CGKeyboardConstraintConstantType constraintConstantType;
#pragma mark - 自定义处理回调

@property (nullable, nonatomic, weak) id<CGKeyboardManagerDelegate> delegate;

/** 实现keyboardManager:showKeyboardNotification:代理方法，代理回调之后是否继续向下执行，默认是NO，不继续执行 */
@property (nonatomic, assign) BOOL didShowKeyboardContinueDealWithNotification;
/** 实现keyboardManager:hideKeyboardNotification:代理方法，代理回调之后是否继续向下执行，默认是NO，不继续执行 */
@property (nonatomic, assign) BOOL didHideKeyboardContinueDealWithNotification;

#pragma mark - 动画之行的参数设置

/** 隐藏键盘显示，或隐藏的动画 */
@property (nonatomic, assign) BOOL hideKeyboardShowHideAnimated;

/** 执行视图动画执行的时间，默认是0，即使用键盘执行的动画时间 */
@property (nonatomic, assign) NSTimeInterval duration;
/** 执行动画UIViewAnimationCurve值，默认是0，即使用键盘的速率值 */
//@property (nonatomic, assign) NSUInteger curve;

/** 键盘在指定view的显示区域 */
//- (CGRect)keyboardRectToView:(UIView *)paramView;

#pragma mark - 输入内容时的处理

/** 开启UITextFieldTextDidChangeNotification通知 */
@property (nonatomic, assign) BOOL openTextFieldTextDidChangeNotification;
/** 开启UITextViewTextDidChangeNotification通知 */
//@property (nonatomic, assign) BOOL openTextViewTextDidChangeNotification;

@end
NS_ASSUME_NONNULL_END
