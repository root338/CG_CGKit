//
//  CGNavigationBarViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarViewController.h"

#import "CGNavigationAppearanceProtocol.h"

@interface CGNavigationBarViewController ()<CGNavigationAppearanceProtocol>

@end

@implementation CGNavigationBarViewController

#pragma mark - CGNavigationAppearanceProtocol
- (BOOL)cg_prefersNavigationBarHidden
{
    return YES;
}

#pragma mark - CGNavigationBarViewDelegate
//当导航栏的背景色为图片时，应该设置状态栏的高度为0，导航栏覆盖状态栏
- (CGRect)cg_statusViewFrame
{
    return CGRectMake(0, 0, self.navigationController ? self.navigationController.navigationBar.width : self.view.width, 20);
}

- (CGRect)cg_navigationBarFrame
{
    CGRect statusViewFrame = [self cg_statusViewFrame];
    return (CGRect){CGPointMake(0, CGRectGetMaxY(statusViewFrame)), self.navigationController ? self.navigationController.navigationBar.size : CGSizeMake(CGRectGetWidth(statusViewFrame), 44)};
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
    if (!self.customStatusViewBackgroundColor) {
        self.navigationBarView.statusView.backgroundColor = self.navigationBar.barTintColor;
    }
}

- (void)setupView
{
    CGRect frame    = self.view.frame;
    self.view   = [[CGNavigationBarView alloc] initWithFrame:frame delegate:self];
}

#pragma mark - 设置属性
- (CGNavigationBarView *)navigationBarView
{
    if ([self.view isKindOfClass:[CGNavigationBarView class]]) {
        return (id)self.view;
    }else {
        return nil;
    }
}

- (UIView *)contentView
{
    return self.navigationBarView.contentView;
}

- (UINavigationBar *)navigationBar
{
    return self.navigationBarView.navigationBar;
}
@end
