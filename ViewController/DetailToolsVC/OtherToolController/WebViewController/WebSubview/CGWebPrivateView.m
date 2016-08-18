//
//  CGWebPrivateView.m
//  TestCG_CGKit
//
//  Created by DY on 16/8/16.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebPrivateView.h"
#import "CGWebView.h"

#import "NSArray+CGAddConstraints.h"

@interface CGWebPrivateView ()
{
    __weak NSLayoutConstraint *_bottomViewHeightConstraint;
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
        
    }
    return self;
}

- (void)setBottomViewHidden:(BOOL)isHidden animated:(BOOL)animated
{
    if (self.bottomView.isHidden == isHidden) {
        return;
    }
    
    
    [UIView animateWithDuration:.3 animations:^{
        <#code#>
    } completion:<#^(BOOL finished)completion#>]
}

- (void)setBottomViewHeight:(CGFloat)bottomViewHeight animated:(BOOL)animated
{
    
}

#pragma mark - 设置属性
- (void)setBottomViewHeight:(CGFloat)bottomViewHeight
{
    [self setBottomViewHeight:bottomViewHeight animated:!self.disableAnimatedChangeViewStatus];
}

- (void)setIsHiddenBottomView:(BOOL)isHiddenBottomView
{
    if (_isHiddenBottomView != isHiddenBottomView) {
        _isHiddenBottomView = isHiddenBottomView;
        [self setBottomViewHidden:isHiddenBottomView animated:!self.disableAnimatedChangeViewStatus];
    }
}

@end
