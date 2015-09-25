//
//  UITextField+CG_Create.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITextField+CG_Create.h"

@implementation UITextField (CG_Create)

+ (instancetype)cg_createTextFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[self alloc] init];
    
    return textField;
}

@end
