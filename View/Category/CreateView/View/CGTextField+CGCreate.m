//
//  CGTextField+CGCreate.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGTextField+CGCreate.h"

@implementation CGTextField (CGCreate)

+ (instancetype)cg_createTextFieldWithPlaceholder:(NSString *)placeholder
{
    CGTextField *textField  = [[self alloc] initWithFrame:CGRectZero];
    textField.placeholder   = placeholder;
    return textField;
}

@end
