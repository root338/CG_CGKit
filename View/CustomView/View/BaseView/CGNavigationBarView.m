//
//  CGNavigationBarView.m
//  TestCG_CGKit
//
//  Created by DY on 16/2/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGNavigationBarView.h"

#import "UIView+CGAddSubview.h"
#import "UIView+CGPropertyValue.h"

@interface CGNavigationBarView ()

@property (nullable, nonatomic, strong, readwrite) UINavigationBar *navigationBar;
@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation CGNavigationBarView

@synthesize navigationBarHidden = _navigationBarHidden;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<CGNavigationBarViewDelegate>)pDelegate
{
    self = [self initWithFrame:frame];
    if (self) {
        
        _delegate   = pDelegate;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createNavigationBar];
    }
    return self;
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    _navigationBarHidden    = hidden;
    if (hidden) {
        if (!animated) {
            //导航栏隐藏，没有动画
            self.navigationBar.hidden   = hidden;
        }
    }else {
        //显示导航栏
        self.navigationBar.hidden   = hidden;
    }
    
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self setupSubviewsLayout];
            
            
        } completion:^(BOOL finished) {
            
            if (hidden) {
                self.navigationBar.hidden   = hidden;
            }
        }];
    }else {
        
        [self setupSubviewsLayout];
    }
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
    _navigationBar  = [[UINavigationBar alloc] initWithFrame:CGRectZero];
    //对导航栏进行设置
    [self cg_setupNavigationBarAppearance];
    
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
    
    if (self.delegate) {
        
        navigationBarFrame  = [self.delegate cg_navigationBarFrame];
    }else {
        
        if (self.currentOrientation == CGDeivceDirectionLandscape) {
            navigationBarFrame   = CGRectMake(0, 0, self.width, 32);
        }else {
            navigationBarFrame   = CGRectMake(0, 0, self.width, 44);
        }
        
        if (!self.isStatusBarHidden) {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
                navigationBarFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
            }else {
                navigationBarFrame.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
            }
        }
    }
    
    if (self.isNavigationBarHidden) {
        navigationBarFrame.origin.y = -CGRectGetMaxY(navigationBarFrame);
    }
    
    CGRect contentViewFrame;
    if (self.isContentViewFullScreen) {
        
        contentViewFrame  = self.bounds;
    }else {
        
        if ([self.delegate respondsToSelector:@selector(cg_contentViewFrame)]) {
            
            contentViewFrame    = [self.delegate cg_contentViewFrame];
        }else {
            
            contentViewFrame    = CGRectMake(0, CGRectGetMaxY(navigationBarFrame), self.width, self.height - CGRectGetMaxY(navigationBarFrame));
        }
    }
    
    self.contentView.frame      = contentViewFrame;
    self.contentView.superview ?: [self addSubview:self.contentView];
    
    self.navigationBar.frame    = navigationBarFrame;
    self.navigationBar.superview ?: [self addSubview:self.navigationBar];
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
    //对内容视图进行设置
    [self cg_setupContentViewAppearance];
    
    return _contentView;
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    if (_navigationBarHidden != navigationBarHidden) {
        
        [self setNavigationBarHidden:navigationBarHidden animated:NO];
    }
}

- (BOOL)isNavigationBarHidden
{
    return _navigationBarHidden;
}

@end
