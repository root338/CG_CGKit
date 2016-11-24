//
//  CGTextFieldInputView.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CGInputAccessoryView, CGInputAccessoryViewAppearance;

/**
 *  文本输入框输入视图上按钮的样式
 */
typedef NS_ENUM(NSInteger, CGInputAccessoryViewButtonType){
    
    CGInputAccessoryViewButtonTypeNone,
    
    /** 完成 */
    CGInputAccessoryViewButtonTypeCarryOut,
    /** 左箭头 */
    CGInputAccessoryViewButtonTypeLeftArrow,
    /** 右箭头 */
    CGInputAccessoryViewButtonTypeRightArrow,
};

@protocol CGInputAccessoryViewDelegate <NSObject>

@optional
/**
 *  文本输入框 inputView 上按钮触发的回调方法
 *
 *  @param type      inputView 中按钮类型
 */
- (void)inputAccessoryView:(CGInputAccessoryView *)inputAccessoryView buttonType:(CGInputAccessoryViewButtonType)type;

/** 设置当前第一响应者 */
- (nullable UIView *)currentFirstResponderInputAccessoryView:(CGInputAccessoryView *)inputAccessoryView;

/** 自动搜索左右箭头是否可用时，搜索输入框的父视图集合 */
- (NSSet<UIView *> *)searchInputRangeViewsInputAccessoryView:(CGInputAccessoryView *)inputAccessoryView;

/**
 是否可以设置为第一响应者

 @param inputAccessoryView 当前inputAccessoryView
 @param view               将要设置为第一响应者的视图
 @param type               点击的按钮，左箭头／右箭头

 @return 是否可以设置为第一响应者
 */
- (BOOL)inputAccessoryView:(CGInputAccessoryView *)inputAccessoryView canBecomeFirstResponderWithView:(__kindof UIView *)view actionButtonType:(CGInputAccessoryViewButtonType)type;

/**
 是否可以取消第一响应者
 
 @param inputAccessoryView 当前inputAccessoryView
 @param view               将要取消第一响应者的视图
 @param type               点击的按钮，完成
 
 @return 是否可以取消第一响应者
 */
- (BOOL)inputAccessoryView:(CGInputAccessoryView *)inputAccessoryView canResignFirstResponderWithView:(__kindof UIView *)view actionButtonType:(CGInputAccessoryViewButtonType)type;

#pragma mark - 直接设置左右箭头是否可用
/** 是否打开左边箭头的可用状态 */
- (nullable UIView *)previousViewInputAccessoryView:(CGInputAccessoryView *)inputAccessoryView;
/** 是否打开右边箭头的可用状态 */
- (nullable UIView *)nextViewInputAccessoryView:(CGInputAccessoryView *)inputAccessoryView;
@end

/**
  输入框的相互切换
 @warning   建议实现代理方法或rangeViews属性方法，减小搜索输入框的搜索范围，否则一直全局窗口搜索效率比较低效
 */
@interface CGInputAccessoryView : UIView

+ (instancetype)defaultInputAccessoryView;

@property (weak, nonatomic) id<CGInputAccessoryViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIButton *leftArrowButton;
@property (nonatomic, strong, readonly) UIButton *rightArrowButton;
@property (nonatomic, strong, readonly) UIButton *finishButton;

@property (nonatomic, copy) void (^didClickCallback)(CGInputAccessoryViewButtonType type, UIButton *sender);

/** 开启自动设置左右箭头是否可用，默认NO */
@property (nonatomic, assign) BOOL enableAutoChangeArrowStatus;
/** 关闭切换第一响应者功能，默认NO */
@property (nonatomic, assign) BOOL disableChangeFirstResponder;

/** 自动搜索左右箭头是否可用时，搜索输入框的父视图集合 */
@property (nullable, nonatomic, strong) NSSet<UIView *> *rangeViews;

@property (nonatomic, strong, readonly) CGInputAccessoryViewAppearance *appearance;

- (instancetype)initWithFrame:(CGRect)frame appearance:(CGInputAccessoryViewAppearance *)appearance NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
