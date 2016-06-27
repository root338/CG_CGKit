//
//  CGKeyboardCacheModel.h
//  QuickAskCommunity
//
//  Created by DY on 16/6/27.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGKeyboardManagerHeader.h"

/** 键盘通知管理的缓冲数据模型 */
@interface CGKeyboardCacheModel : CGBaseObject

@property (nonatomic, assign) CGKeyboardNotificationType keyboardNotificationType;

@property (nullable, nonatomic, weak) UIView *targetView;

@property (nullable, nonatomic, weak) NSLayoutConstraint *targetLayoutConstraint;



@end
