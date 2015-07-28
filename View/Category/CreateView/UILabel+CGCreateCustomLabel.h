//
//  UILabel+CreateLabel.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  快捷创建UILabel
 */
@interface UILabel (CGCreateCustomLabel)


+ (UILabel *)cg_createLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

@end
