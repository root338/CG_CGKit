//
//  CGWebPrivateView.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebPrivateView.h"
#import "CGWebView.h"

#import "UIView+CGAddConstraints.h"
#import "NSArray+CGAddConstraints.h"

@interface CGWebPrivateView ()
{
    __weak NSLayoutConstraint *_bottomViewHeightConstraint;
    //底部视图顶部与父视图的约束
    __weak NSLayoutConstraint *_bottomViewTopConstraint;
}

@property (nonatomic, strong, readwrite) CGWebView * webView;
@property (nonatomic, strong, readwrite) UIView    * bottomView;

@end

@implementation CGWebPrivateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _webView    = [[CGWebView alloc] init];
        _bottomView = [[UIView alloc] init];
        
        [self addSubview:_webView];
        [self addSubview:_bottomView];
        
        NSArray *subviews   = @[_webView, _bottomView];
        [subviews cg_autoArrangementType:CGSubviewsArrangementTypeVertical marginInsets:UIEdgeInsetsZero setupSubviewLayoutExculdingEdge:^BOOL(UIView * _Nonnull view, CGLayoutEdge exculdingEdge) {
            BOOL isExculdingEdge    = NO;
            if (view == _bottomView && exculdingEdge == CGLayoutEdgeBottom) {
                isExculdingEdge     = YES;
            }
            return isExculdingEdge;
        }];
        [UIView cg_autoSetPriority:980 forConstraints:^{
            [_bottomView cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom];
        }];
    }
    return self;
}

- (void)setBottomViewHidden:(BOOL)isHidden animated:(BOOL)animated
{
    if (self.bottomView.isHidden == isHidden) {
        return;
    }
    
    _isHiddenBottomView = isHidden;
    if (isHidden) {
        _bottomViewTopConstraint    = [self.bottomView cg_autoInverseAttribute:CGLayoutEdgeTop toItem:self.bottomView.superview];
    }else {
        [self.bottomView.superview removeConstraint:_bottomViewTopConstraint];
    }
    
    [self setupUpdateConstraintsWithAnimated:animated completion:^(BOOL finished) {
        self.bottomView.hidden  = isHidden;
    }];
}

- (void)setBottomViewHeight:(CGFloat)bottomViewHeight animated:(BOOL)animated
{
    if (self.bottomView.height == bottomViewHeight) {
        return;
    }
    
    if (self.bottomView.isHidden) {
        animated    = NO;
    }
    
    _bottomViewHeight   = bottomViewHeight;
    if (_bottomViewHeightConstraint) {
        _bottomViewHeightConstraint.constant    = bottomViewHeight;
    }else {
        _bottomViewHeightConstraint = [self.bottomView cg_autoDimension:CGDimensionHeight fixedLength:bottomViewHeight];
    }
    
    [self setupUpdateConstraintsWithAnimated:animated completion:nil];
}

- (void)setupUpdateConstraintsWithAnimated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion
{
    [self setNeedsUpdateConstraints];
    
    CGFloat duration    = animated ? 0.3 : 0;
    
    [UIView animateWithDuration:duration animations:^{
        
        [self layoutIfNeeded];
    } completion:completion];
}

#pragma mark - 设置属性
- (void)setBottomViewHeight:(CGFloat)bottomViewHeight
{
    [self setBottomViewHeight:bottomViewHeight animated:!self.disableAnimatedChangeViewStatus];
}

- (void)setIsHiddenBottomView:(BOOL)isHiddenBottomView
{
    [self setBottomViewHidden:isHiddenBottomView animated:!self.disableAnimatedChangeViewStatus];
}

@end
