//
//  CGTitleBaseView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGTitleBaseView.h"
#import "Masonry.h"

@interface CGTitleBaseView ()
{
    ///标识约束有没有添加成功
    BOOL didSetupConstraints;
}
@end

@implementation CGTitleBaseView

@synthesize rightViewPriority = _rightViewPriority;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rightViewPriority = 250;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setRightViewPriority:(NSInteger)rightViewPriority
{
    if (self.rightView) {
        return;
    }
    _rightViewPriority = rightViewPriority;
    [self.leftView setContentHuggingPriority:self.rightViewPriority forAxis:UILayoutConstraintAxisHorizontal];
}

- (NSInteger)rightViewPriority
{
    if (_rightViewPriority <= 1) {
        _rightViewPriority = 250;
    }
    return _rightViewPriority;
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (self.rightView) {
//                make.top.leading.and.bottom.equalTo(self).with.insets(self.edgeInsetView);
                make.top.equalTo(self.mas_top).offset(self.edgeInsetView.top);
                make.leading.equalTo(self.mas_leading).with.offset(self.edgeInsetView.left);
                make.bottom.equalTo(self.mas_bottom).with.offset(-self.edgeInsetView.bottom);
                if (self.viewSpace == FLT_MAX) {
                    make.trailing.lessThanOrEqualTo(self.rightView.mas_leading);
                }else {
                    make.trailing.equalTo(self.rightView.mas_leading).offset(-self.viewSpace);
                }
            }else {
                make.edges.equalTo(self).insets(self.edgeInsetView);
            }
            
        }];
        
        if (self.rightView) {
            [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.trailing.and.bottom.equalTo(self).insets(self.edgeInsetView);
                make.top.equalTo(self).with.offset(self.edgeInsetView.top);
                make.bottom.equalTo(self).with.offset(-self.edgeInsetView.bottom);
                make.trailing.equalTo(self).with.offset(-self.edgeInsetView.right);
            }];
            [self.rightView setContentHuggingPriority:self.rightViewPriority forAxis:UILayoutConstraintAxisHorizontal];
        }
        
        if (self.fixedHeight != 0) {
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.fixedHeight));
            }];
        }
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
@end
