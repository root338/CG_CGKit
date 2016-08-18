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

@interface CGWebViewController ()<CGWebPrivateViewDelegate>
{
    UIBarButtonItem *goBackItem;
    UIBarButtonItem *goForwardItem;
}

@property (nonatomic, strong) UIProgressView *progressDefultView;

@property (nonatomic, readonly) CGWebPrivateView *privateView;
@end

@implementation CGWebViewController

#pragma mark - 事件
- (void)handleWebViewBack:(UIBarButtonItem *)sender
{
    
}

- (instancetype)init
{
    self    = [super init];
    if (self) {
        self.view   = [[CGWebPrivateView alloc] initWithDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 设置页面内容

#pragma mark - 设置属性
@end
