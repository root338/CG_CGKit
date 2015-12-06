//
//  CGTitleTextField.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTitleTextFieldView.h"

#import "UIView+CG_CGAreaCalculate.h"

@interface CGTitleTextFieldView ()

/** 输入文本框 */
@property (strong, nonatomic, readwrite) CGBaseTextField *textField;

/** 标题视图 */
@property (strong, nonatomic, readwrite) CGBaseLabel *titleLabel;

@end

@implementation CGTitleTextFieldView

- (void)initialization
{
    _positionStyle = CGViewPositionStyleLeft;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateTitleTextFieldViewLayout];
}

- (void)updateTitleTextFieldViewLayout
{
    switch (self.positionStyle) {
        case CGViewPositionStyleTop:
        {
            
            self.textField.frame = CG_CGRectWithExcludeTop(self.bounds, self.marginEdgeInsets, self.textField.height);
            self.titleLabel.frame = CG_CGRectWithExcludeBottom(self.bounds, self.marginEdgeInsets, self.height - (self.marginEdgeInsets.top + self.marginEdgeInsets.bottom + self.textField.height));
        }
            break;
        case CGViewPositionStyleLeft:
        {
            self.textField.frame
        }
            break;
        default:
            break;
    }
}

@end
