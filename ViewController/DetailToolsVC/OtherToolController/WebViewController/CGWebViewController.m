//
//  CGWebViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/4/20.
//  Copyright © 2016年 apple. All rights reserved.
//

@import WebKit;

#import "CGWebViewController.h"

#import "CGWebView.h"
#import "CGWebPrivateView.h"

#import "UIView+CGAddConstraints.h"

#import "Value+Constant.h"

@interface CGWebViewController ()
{
    
}

@property (nonatomic, strong) UIProgressView *progressDefultView;

@property (nonatomic, strong) CGWebPrivateView *privateView;
@end

@implementation CGWebViewController

#pragma mark - 事件

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.privateView.superview) {
        [self.view addSubview:self.privateView];
        [self.privateView cg_autoEdgesInsetsZeroToSuperview];
    }
}

#pragma mark - 设置属性

- (CGWebPrivateView *)privateView
{
    if (_privateView) {
        return _privateView;
    }
    
    _privateView = [[CGWebPrivateView alloc] init];
    
    return _privateView;
}

- (CGWebView *)webView
{
    return self.privateView.webView;
}

@end
