//
//  CGPlaceholderLabel.m
//  BaseModel
//
//  Created by 345 on 14/12/17.
//  Copyright (c) 2014年 345. All rights reserved.
//

#import "CGPlaceholderLabel.h"

@interface CGPlaceholderLabel ()
{
    ///保存设置label的文字
    NSAttributedString *labelAttributedText;
    
    ///标识当前传入的字符串为设置的提示语
    BOOL markIsPlaceholder;
}
//@property (strong, nonatomic, readwrite) UILabel *placeholderLabel;


@end

@implementation CGPlaceholderLabel

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = placeholderText;
    [self setupPlaceholder];
}

- (void)setAttributedDictionary:(NSDictionary *)attributedDictionary
{
    _attributedDictionary = attributedDictionary;
    [self setupPlaceholder];
}

- (void)setupPlaceholder
{
    self.placeholderAttributedText = [[NSAttributedString alloc] initWithString:self.placeholderText attributes:self.attributedDictionary];
}

- (void)setPlaceholderAttributedText:(NSAttributedString *)placeholderAttributedText
{
    _placeholderAttributedText = placeholderAttributedText;
    
    
    if ([self inputTextIsNULL]) {
        markIsPlaceholder = YES;
        self.attributedText = placeholderAttributedText;
        markIsPlaceholder = NO;
    }
}

- (void)setText:(NSString *)text
{
    //由于当设置text值为 空值时系统不会自动调用setAttributedText方法，需手动调用
    if (text.length) {
        [super setText:text];
    }else {
        //当出入nil时 临时存储的对象labelAttributedText也会被设置为空
        [self setAttributedText:nil];
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (!markIsPlaceholder) {
        labelAttributedText = attributedText;
        if ([self inputTextIsNULL]) {
            attributedText = self.placeholderAttributedText;
        }
    }
    [super setAttributedText:attributedText];
}

- (BOOL)inputTextIsNULL
{
    return !labelAttributedText || !labelAttributedText.length;
}
@end
