//
//  CGButtonContentView.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGDoubleButtonsView.h"

#import "UIButton+CGCreateCustomButton.h"
#import "UIView+CG_CGAreaCalculate.h"


@interface CGDoubleButtonsView ()

@property (strong, nonatomic, readwrite) CGBaseButton *leftButton;

@property (strong, nonatomic, readwrite) CGBaseButton *rightButton;

@end

@implementation CGDoubleButtonsView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.leftButton sizeToFit];
    [self.rightButton sizeToFit];
    
    self.leftButton.frame = CG_CGRectWithExcludeRight(self.bounds, self.marginEdgeInsets, self.leftButton.width);
    if (self.subviewsSpace > 0) {
        
        self.rightButton.frame = CG_CGRectWithExcludeHorizontal(self.bounds, self.marginEdgeInsets, self.leftButton.maxX + self.subviewsSpace, self.rightButton.width);
    }else {
        
        self.rightButton.frame = CG_CGRectWithExcludeHorizontal(self.bounds, self.marginEdgeInsets, self.width - (self.leftButton.width + self.rightButton.width), self.rightButton.width);
    }
}

#pragma mark - 设置属性
- (CGBaseButton *)leftButton
{
    if (_leftButton) {
        return _leftButton;
    }
    
    _leftButton = [CGBaseButton cg_createDefaultButton];
    
    return _leftButton;
}

- (CGBaseButton *)rightButton
{
    if (_rightButton) {
        return _rightButton;
    }
    
    _rightButton = [CGBaseButton cg_createDefaultButton];
    
    return _rightButton;
}

@end
