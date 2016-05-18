//
//  CGNavigationBarViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarViewController.h"

#import "CGNavigationAppearanceProtocol.h"

#import "CGPrintLogHeader.h"

@interface CGNavigationBarViewController ()<CGNavigationAppearanceProtocol>

@end

@implementation CGNavigationBarViewController

#pragma mark - CGNavigationAppearanceProtocol
- (BOOL)cg_prefersNavigationBarHidden
{
    return YES;
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    [self.navigationBarView setNavigationBarHidden:hidden animated:animated];
}

#pragma mark - CGNavigationBarViewDelegate
/** 当状态栏高度为0，自动设置状态栏高度为64 */
- (CGRect)cg_navigationBarFrame
{
    CGFloat height  = 64;
    CGFloat width   = self.navigationController ? self.navigationController.navigationBar.width : self.view.width;
    return CGRectMake(0, self.isNavigationBarHidden ? -height : 0, width, height);
}

- (void)loadView
{
    [super loadView];
    [self setupView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setupView
{
    CGRect frame    = self.view.frame;
    self.view   = [[CGNavigationBarView alloc] initWithFrame:frame delegate:self];
    self.view.backgroundColor   = [UIColor whiteColor];
}

- (void)dealloc
{
    CGInfoLog(@"已释放");
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

- (void)setIsNavigationBarHidden:(BOOL)isNavigationBarHidden
{
    self.navigationBarView.isNavigationBarHidden    = isNavigationBarHidden;
}

- (BOOL)isNavigationBarHidden
{
    return self.navigationBarView.isNavigationBarHidden;
}
@end
