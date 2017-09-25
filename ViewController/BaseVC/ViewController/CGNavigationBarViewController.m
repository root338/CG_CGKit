//
//  CGNavigationBarViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarViewController.h"

#import "CGNavigationAppearanceProtocol.h"
#import "UIViewController+CGPropertyValue.h"

#import "CGNavigationBarView.h"

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
    CGRect  frame;
    if (self.navigationController) {
        frame   = self.navigationController.navigationBar.bounds;
    }else {
        if (self.currentOrientation == CGDeivceDirectionLandscape) {
            frame   = CGRectMake(0, 0, self.view.width, 32);
        }else {
            frame   = CGRectMake(0, 0, self.view.width, 44);
        }
    }
    if (!self.isStatusBarHidden) {
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
            frame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
        }else {
            frame.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    
    return frame;
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

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    self.navigationBarView.navigationBarHidden  = navigationBarHidden;
}

- (BOOL)isNavigationBarHidden
{
    return self.navigationBarView.isNavigationBarHidden;
}
@end
