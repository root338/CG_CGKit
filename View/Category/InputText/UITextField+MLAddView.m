//
//  UITextField+MLAddView.m
//  QuickAskCommunity
//
//  Created by apple on 2018/11/1.
//  Copyright © 2018 ym. All rights reserved.
//

#import "UITextField+MLAddView.h"

@implementation UITextField (MLAddView)

- (UILabel *)setLeftViewWithText:(NSString *)text font:(UIFont *)font color:(UIColor *)color {
    
    if (font == nil || color == nil) {
        UILabel *leftView = nil;
        if ([self.leftView isKindOfClass:[UILabel class]]) {
            leftView = (id)self.leftView;
        }
        if (font == nil) {
            font = leftView.font?: [UIFont systemFontOfSize:UIFont.systemFontSize];
        }
        if (color == nil) {
            color = leftView.textColor?: [UIColor blackColor];
        }
    }
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : font,
                                 NSForegroundColorAttributeName : color,
                                 };
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return [self setLeftViewWithAttributedString:att];
}

- (UILabel *)setLeftViewWithAttributedString:(NSAttributedString *)attributedString {
    
    UILabel *targetLabel = nil;
    if ([self.leftView isKindOfClass:[UILabel class]]) {
        targetLabel = (id)self.leftView;
    }
    
    if (targetLabel == nil) {
        targetLabel = UILabel.new;
    }
    
    targetLabel.attributedText = attributedString;
    self.leftView = targetLabel;
    
    return targetLabel;
}

- (UIImageView *)setRightViewWithLocalImageName:(NSString *)localImageName {
    return [self setRightViewWithImage:[UIImage imageNamed:localImageName]];
}

- (UIImageView *)setRightViewWithImage:(UIImage *)image {
    UIImageView *imageView = UIImageView.new;
    imageView.image = image;
    self.rightView = imageView;
    return imageView;
}

@end
