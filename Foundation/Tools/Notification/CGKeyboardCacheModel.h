//
//  CGKeyboardCacheModel.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/27.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGKeyboardManagerHeader.h"

/** 键盘通知管理的缓存数据模型 */
@interface CGKeyboardCacheModel : CGBaseObject

@property (nonatomic, assign) CGKeyboardLayoutType  layoutType;

@property (nonatomic, assign) CGKeyboardNotificationType    keyboardNotificationType;

@property (nullable, nonatomic, weak) UIView *targetView;

#pragma mark - 约束相关
/** 目标视图的底部约束 */
@property (nullable, nonatomic, weak) NSLayoutConstraint *targetLayoutConstraint;
/** 
 *  约束的常量值 
 *  @param 纪录约束才开始时的常量值，因为通过键盘改变视图时都通过修改该值改变
 */
@property (nonatomic, assign) CGFloat originalConstant;

#pragma mark - 非约束相关

@property (nonatomic, assign) CGKeyboardChangeFrameType keyboardChangeFrameType;
/** 视图原来的显示区域 */
@property (nonatomic, assign) CGRect originalFrame;
//@property (nonatomic, assign) CGSize    maxSize;
//@property (nonatomic, assign) CGSize    minSize;
//@property (nonatomic, assign) CGPoint   minPoint;
//@property (nonatomic, assign) CGPoint   maxPoint;



@end
