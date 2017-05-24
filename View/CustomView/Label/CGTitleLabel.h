//
//  CGTitleLabel.h
//  soho
//
//  Created by 345 on 15/1/6.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 设置UIlabel的标题
 
 当使用xib时默认在xib中的title为提示文字，在xib环境下优先使用 Label 的attributedText属性
 
 */
@interface CGTitleLabel : UILabel

@property (nullable, nonatomic, strong) NSDictionary<NSString *, id> *titleAttributesDic;
@property (nullable, nonatomic, strong) NSDictionary<NSString *, id> *contentAttributesDic;

@property (nullable, nonatomic, strong) NSString *titleText;
@property (nullable, nonatomic, strong) NSString *contentText;

/**
 显示的标题的属性
 */
@property (nullable, strong, nonatomic) NSAttributedString *title;

/**
 显示内容的属性
 */
@property (nullable, strong, nonatomic) NSAttributedString *content;

/** 没有内容时隐藏标题, 默认为 NO */
@property (nonatomic, assign) BOOL isNotContentIsHideTitle;

/**
 设置标题与内容的间距
 
 只在有标题的情况下有效
 */
//@property (assign, nonatomic) float spacingBetweenTheTitleAndContent;
@end

NS_ASSUME_NONNULL_END
