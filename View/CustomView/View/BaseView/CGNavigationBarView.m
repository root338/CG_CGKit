//
//  CGNavigationBarView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarView.h"

#import "UIView+CGAddSubview.h"

@interface CGNavigationBarView ()

@property (nullable, nonatomic, strong, readwrite) UINavigationBar *navigationBar;
@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation CGNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CGNavigationBarViewDelegate>)pDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate   = pDelegate;
        [self cg_initialization];
    }
    return self;
}

- (void)cg_initialization
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
//    if (!self.navigationBar.barTintColor) {
//        self.navigationBar.barTintColor = [UIColor whiteColor];
//        self.navigationBar.translucent  = NO;
//    }
    
    //立即更新视图布局，否则子类在视图添加内容时有时会显示错误
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setupSubviewsLayout
{
    
    CGRect navigationBarFrame;
    if ([self.delegate respondsToSelector:@selector(cg_contentViewFrame)]) {
        
        self.contentView.frame  = [self.delegate cg_contentViewFrame];
    }else {
        
        navigationBarFrame      = [self.delegate cg_navigationBarFrame];
        self.contentView.frame      = CGRectMake(0, CGRectGetMaxY(navigationBarFrame), self.width, self.height - CGRectGetMaxY(navigationBarFrame));
    }
    
    if ([self cg_addSubview:self.contentView]) {
        
        //对内容视图进行设置
        [self cg_setupContentViewAppearance];
    }
    
    self.navigationBar.frame    = navigationBarFrame;
    if ([self cg_addSubview:self.navigationBar]) {
        
        //对导航栏进行设置
        [self cg_setupNavigationBarAppearance];
    }
}

#pragma mark - 设置内容视图样式
- (void)cg_setupNavigationBarAppearance{}
- (void)cg_setupContentViewAppearance{};

#pragma mark - 重写系统方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupSubviewsLayout];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        //移动视图
//        !_navigationBar.superview   ?: [self bringSubviewToFront:_navigationBar];
    }
}

#pragma mark - 设置属性

- (UIView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
//    _contentView.backgroundColor    = [UIColor whiteColor];
    
    return _contentView;
}

@end
