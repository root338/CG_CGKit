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
    _isNavigationBarHidden  = hidden;
    CGFloat originY  = hidden ? - self.navigationBar.height : 0;
    if (!hidden || !animated) {
        //显示时，或没有动画时
        self.navigationBar.hidden   = hidden;
    }
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.navigationBar.yOrigin  = originY;
        } completion:^(BOOL finished) {
            
            if (hidden) {
                self.navigationBar.hidden   = hidden;
            }
        }];
    }else {
        
        self.navigationBar.yOrigin  = originY;
    }
}

#pragma mark - CGNavigationBarViewDelegate
/** 当状态栏高度为0，自动设置状态栏高度为64 */
- (CGRect)cg_navigationBarFrame
{
    CGFloat width   = self.navigationController ? self.navigationController.navigationBar.width : self.view.width;
    return CGRectMake(0, 0, width, 64);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupView];
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
    if (_isNavigationBarHidden != isNavigationBarHidden) {
        
        [self setNavigationBarHidden:isNavigationBarHidden animated:NO];
    }
}
@end
