//
//  CGTextField.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTextField.h"

@implementation CGTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self    = [super initWithFrame:frame];
    if (self) {
        [self setupTextContent];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupTextContent];
}

- (void)setupTextContent
{
    //初始化文本框时，设置UITextField的文本内容为@"  "，在经过0零秒后重新设置text
    //原因，在iOS 9 以上版本使用CGKeyboardManager，约束控制视图显示时，在第一次输入内容并切换文本框时文字会出现飞入想象，此功能时消除这种飞入现象
    NSString *tempText  = @"  ";
    if (self.text.length == 0) {
        self.text   = tempText;
        [self performSelector:@selector(setupTextContent) withObject:nil afterDelay:0];
    }else {
        
        if ([self.text isEqualToString:tempText]) {
            self.text   = nil;
        }
    }
}

@end
