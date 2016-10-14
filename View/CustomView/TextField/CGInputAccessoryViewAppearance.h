//
//  CGInputAccessoryViewAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/** 输入文本框的样式声明 */
@interface CGInputAccessoryViewAppearance : NSObject

#pragma mark - InputAccessoryView 样式
/** 默认白色 */
@property (nullable, strong, nonatomic) UIColor *backgroundColor;
@property (nullable, strong, nonatomic) UIImage *backgroundImage;

#pragma mark - 按钮样式的设置
/** 箭头颜色, 默认蓝色 */
@property (nullable, nonatomic, strong) UIColor *arrowImageTintColor;
/** 箭头线宽, 默认 1.5 */
@property (nonatomic, assign) CGFloat arrowLineWidth;
/** 箭头大小, 默认{25, 25} */
@property (nonatomic, assign) CGSize arrowSize;


@property (nullable, strong, nonatomic) UIFont *titleFont;
/** 按钮标题的颜色 key:@(UIControlState), value: UIColor * */
@property (nullable, nonatomic, strong) NSDictionary<NSNumber *, UIColor *> *titleColors;
/** 完成按钮标题，默认完成 */
@property (nonatomic, strong) NSString *finishTitle;

+ (instancetype)defalutAppearance;
@end

NS_ASSUME_NONNULL_END
