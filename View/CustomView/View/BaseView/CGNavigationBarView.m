//
//  CGNavigationBarView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarView.h"

#import "UIView+CGAddView.h"

@interface CGNavigationBarView ()

@property (nonatomic, strong, readwrite) UIView *statusView;
@property (nullable, nonatomic, strong, readwrite) UINavigationBar *navigationBar;
@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation CGNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CGNavigationBarViewDelegate>)pDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate   = pDelegate;
    }
    return self;
}

- (void)initialization
{
    [self createNavigationBar];
//    [self addNavigationBarAndContentViewSubviews];
}

#pragma mark - 设置 navigationBar 和 contentView
//- (void)addNavigationBarAndContentViewSubviews
//{
//    if (!self.navigationBar.superview) {
//        [self addSubview:self.navigationBar];
//    }
//    if (!self.contentView.superview) {
//        [self addSubview:self.contentView];
//    }
//}

- (void)createNavigationBar
{
    self.navigationBar  = [[UINavigationBar alloc] initWithFrame:CGRectZero];
}

- (void)setupSubviewsLayout
{
    CGRect statusViewFrame      = [self.delegate cg_statusViewFrame];
    self.statusView.frame       = statusViewFrame;
    if ([self cg_addSubview:self.statusView]) {
        
        //对状态栏进行设置
        [self cg_setupStatusViewAppearance];
    }
    
    CGRect navigationBarFrame   = [self.delegate cg_navigationBarFrame];
    self.navigationBar.frame    = navigationBarFrame;
    if ([self cg_addSubview:self.navigationBar]) {
        
        //对导航栏进行设置
        [self cg_setupNavigationBarAppearance];
    }
    
    self.contentView.frame      = CGRectMake(0, CGRectGetMaxY(navigationBarFrame), self.width, self.height - CGRectGetMaxY(navigationBarFrame));
    if ([self cg_addSubview:self.contentView]) {
        
        //对内容视图进行设置
        [self cg_setupContentViewAppearance];
    }
}

#pragma mark - 设置内容视图样式
- (void)cg_setupStatusViewAppearance{}
- (void)cg_setupNavigationBarAppearance{}
- (void)cg_setupContentViewAppearance{};

#pragma mark - 重写系统方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupSubviewsLayout];
}

#pragma mark - 设置属性

- (UIView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return _contentView;
}

- (UIView *)statusView
{
    if (_statusView) {
        return _statusView;
    }
    
    _statusView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return _statusView;
}

@end
