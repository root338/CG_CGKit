//
//  CGNavigationBarViewController.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarViewController.h"

#import "CGNavigationAppearanceProtocol.h"

//视图类
#import "CGNavigationBarView.h"

@interface CGNavigationBarViewController ()<CGNavigationAppearanceProtocol, CGNavigationBarViewDelegate>


@end

@implementation CGNavigationBarViewController

#pragma mark - CGNavigationAppearanceProtocol
- (BOOL)cg_prefersNavigationBarHidden
{
    return YES;
}

#pragma mark - CGNavigationBarViewDelegate
- (CGRect)cg_statusViewFrame
{
    return CGRectMake(0, 0, self.navigationController.navigationBar.width, 20);
}

- (CGRect)cg_navigationBarFrame
{
    return (CGRect){CGPointMake(0, CGRectGetMaxY([self cg_statusViewFrame])), self.navigationController.navigationBar.size};
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
