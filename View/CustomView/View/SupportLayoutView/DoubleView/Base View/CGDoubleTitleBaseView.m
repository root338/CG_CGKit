//
//  CGTitleBaseView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/4/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGDoubleTitleBaseView.h"

#import "UIView+CGAddConstraints.h"

@interface CGDoubleTitleBaseView ()
{
    ///标识约束有没有添加成功
    BOOL didSetupConstraints;
}
@end

@implementation CGDoubleTitleBaseView

@synthesize rightViewPriority = _rightViewPriority;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setRightViewPriority:250];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
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
        
        if (self.leftView.superview) {
            
            if (self.rightView.superview) {
                
                [self.leftView cg_autoEdgesToSuperviewEdgesWithInsets:self.edgeInsetView excludingEdge:CGLayoutEdgeTrailing];
                
                CGFloat viewsBetweenSpace;
                NSLayoutRelation relation;
                if (self.viewSpace == FLT_MAX) {
                    
                    viewsBetweenSpace   = 0;
                    relation            = NSLayoutRelationGreaterThanOrEqual;
                }else {
                    
                    viewsBetweenSpace   = self.viewSpace;
                    relation            = NSLayoutRelationEqual;
                }
                
                [self.leftView cg_attribute:NSLayoutAttributeTrailing
                                  relatedBy:relation
                                     toItem:self.rightView
                                  attribute:NSLayoutAttributeLeading
                                   constant:viewsBetweenSpace];
            }else {
                [self.leftView cg_autoEdgesToSuperviewEdgesWithInsets:self.edgeInsetView];
            }
        }
        
        if (self.rightView.superview) {
            
            [self.rightView cg_autoEdgesToSuperviewEdgesWithInsets:self.edgeInsetView excludingEdge:CGLayoutEdgeLeading];
            [self.rightView setContentHuggingPriority:self.rightViewPriority forAxis:UILayoutConstraintAxisHorizontal];
        }
        
        if (self.fixedHeight != 0) {
            
            [self cg_autoDimension:CGDimensionHeight fixedLength:self.fixedHeight];
        }
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
@end
