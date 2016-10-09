//
//  CGTextFieldInputView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/23.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "CGInputAccessoryView.h"

#import "CGArrowIconConfig.h"
#import "UIImage+CGDrawIcon.h"

#import "CGAngleRadianHeader.h"
#import "UIView+CGAddSubview.h"
#import "UIView+CGAddConstraints.h"
#import "NSArray+CGAddConstraints.h"
#import "UIButton+CGCreateCustomButton.h"

@interface CGInputAccessoryView ()
{
    
}

@property (nonatomic, strong, readwrite) UIButton *leftArrowButton;
@property (nonatomic, strong, readwrite) UIButton *rightArrowButton;
@property (nonatomic, strong, readwrite) UIButton *finishButton;

@end

@implementation CGInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    CGArrowIconConfig *config   = [CGArrowIconConfig defaultArrowConfig];
    config.size                 = CGSizeMake(20, 20);
    config.angle                = 90;
    config.lineWidth            = 1.5;
    
    UIImage *normalArrowImage   = [UIImage drawArrowWithConfig:config];
    
    _leftArrowButton    = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:normalArrowImage];
    
    _rightArrowButton   = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem normalImage:normalArrowImage];
    _rightArrowButton.imageView.transform   = CGAffineTransformMakeRotation(_CG_RadianForAngle(180));
    _finishButton       = [UIButton cg_createButtonWithButtonType:UIButtonTypeSystem title:@"完成" titleColor:nil font:nil];
    
    NSArray *subviews   = @[
                            _leftArrowButton,
                            _rightArrowButton,
                            _finishButton
                            ];
    
    [self cg_addSubviews:subviews];
    
    CGFloat verticalSpace       = 1;
    CGFloat horizontalSpace     = 8;
    subviews.subviewsSpaceValue = horizontalSpace;
    
    [subviews cg_autoSetupHorizontalSubviewsLayoutAxisHorizontalWithMarginInsets:UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace) setupSubviewsSpace:nil setupSubviewsLayoutRelation:^NSLayoutRelation(UIView * _Nonnull view1, CGLayoutEdge view1LayoutEdge, UIView * _Nonnull view2, CGLayoutEdge view2LayoutEdge) {
        NSLayoutRelation relation = NSLayoutRelationEqual;
        if (view1 == _rightArrowButton && view2 == _finishButton) {
            relation    = NSLayoutRelationGreaterThanOrEqual;
        }
        return relation;
    } setupSubviewLayoutRelation:nil];
    
    self.backgroundColor    = [UIColor lightGrayColor];
}

@end
