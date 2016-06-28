//
//  CGKeyboardManager.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/24.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGKeyboardManagerHeader.h"

NS_ASSUME_NONNULL_BEGIN

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
 *  @param 不使用属性firstResponderView
 */
- (nullable UIView *)firstResponderViewWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification;

/** 
 *  设置第一响应者所在的滑动视图
 *  @param 和属性scrollView一样
 */
- (nullable UIScrollView *)scrollViewWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification;

/** 
 *  设置需要改变frame的视图
 *  @param  和属性keyboardFrameDidChangeTheNeedToChangeFrameTheView一样，表示当弹起或隐藏键盘时需要改变的视图frame
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
 *  @param 和属性keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint一样
 */
- (NSLayoutConstraint *)targetViewBottomConstraintWithKeyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification needChangeFrameTheView:(UIView *)needChangeFrameTheView;

/** 
 *  使用约束时返回偏移的距离
 *  @param constant 偏移的距离
 */
- (void)keyboardManager:(CGKeyboardManager *)keyboardManager notification:(NSNotification *)notification constant:(CGFloat)constant;
@end

/** 键盘通知管理 */
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
    !当设置delegate时，并实现显示，隐藏代理方法时，设置的scrollView不进行处理
 */

/** 当有键盘通知改变视图大小时改变其滑动视图contentOffset */
@property (nullable, nonatomic, weak) UIScrollView *scrollView;
/** 第一响应者 */
@property (nullable, nonatomic, weak) UIView *firstResponderView;
/** 键盘显示区域发生改变时需要改变的view  @warning 改变该视图的显示区域 */
@property (nullable, nonatomic, weak) UIView *keyboardFrameDidChangeTheNeedToChangeFrameTheView;
/** 键盘显示区域发生改变时需要改变的view的底部约束  @warning 改变该视图的显示区域 */
@property (nullable, nonatomic, weak) NSLayoutConstraint *keyboardFrameDidChangeTheNeedToChangeTheViewBottomConstraint;

/** 修改frame的类型 @param 默认为CGKeyboardChangeFrameTypeSize */
@property (nonatomic, assign) CGKeyboardChangeFrameType keyboardChangeFrameType;

#pragma mark - 自定义处理回调

@property (nullable, nonatomic, weak) id<CGKeyboardManagerDelegate> delegate;

/** 实现keyboardManager:showKeyboardNotification:代理方法，代理回调之后是否继续向下执行，默认是NO，不继续执行 */
@property (nonatomic, assign) BOOL didShowKeyboardContinueDealWithNotification;
/** 实现keyboardManager:hideKeyboardNotification:代理方法，代理回调之后是否继续向下执行，默认是NO，不继续执行 */
@property (nonatomic, assign) BOOL didHideKeyboardContinueDealWithNotification;

#pragma mark - 动画之行的参数设置
/** 执行视图动画执行的时间，默认是0，即使用键盘执行的动画时间 */
@property (nonatomic, assign) NSTimeInterval duration;
/** 执行动画UIViewAnimationCurve值，默认是0，即使用键盘的速率值 */
//@property (nonatomic, assign) NSUInteger curve;


/** 键盘在指定view的显示区域 */
//- (CGRect)keyboardRectToView:(UIView *)paramView;
@end
NS_ASSUME_NONNULL_END