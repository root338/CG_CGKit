//
//  CGSingleContentView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleContentView.h"

#import "CGSingleBaseContentView.h"

#import "UIView+CGAddConstraints.h"

@interface CGSingleContentView ()<CGSingleViewDataSource, CGRadioViewDelegate>
{
    BOOL didSetupConstraints;
    
//    CGSingleBaseContentView *_contentView;
}

@property (strong, nonatomic) CGSingleBaseContentView *contentView;
@end

@implementation CGSingleContentView

@dynamic defaultSelectedIndex;
@dynamic dataSource;

#pragma mark - create (init) 

#pragma mark - setup property

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex
{
    [[self contentView] initializationSelectedIndex:defaultSelectedIndex];
}

#pragma mark - setup content view
- (void)setTitleArray:(NSMutableArray *)titleArray
{
    if (![_titleArray isEqualToArray:titleArray]) {
        _titleArray = titleArray;
        [self setupContentView];
    }
}

- (CGSingleBaseContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[CGSingleBaseContentView alloc] init];
        
        //放在_contentView.dataSource = self;代码前面时，默认选择时也会回调
        _contentView.delegate = self;
        
        [self addSubview:_contentView];
    }
    return _contentView;
}

///用于初始化内容视图
- (void)setupContentView
{
    [self contentView].dataSource = self;
}

- (void)setDataSource:(id<CGSingleViewDataSource>)dataSource
{
    self.contentView.dataSource = dataSource;
}

- (id<CGSingleViewDataSource>)dataSource
{
    return self.contentView.dataSource;
}

- (void)setTitleAppearance:(CGRadioTitleCellAppearance *)titleAppearance
{
    self.contentView.radioTitleAppearance   = titleAppearance;
}

- (CGRadioTitleCellAppearance *)titleAppearance
{
    return self.contentView.radioTitleAppearance;
}

#pragma mark - update layout
- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [_contentView cg_autoEdgesInsetsZeroToSuperview];
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - CGSingleViewDataSource
- (NSInteger)singleView:(CGRadioView *)singleView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (NSString *)singleView:(CGRadioView *)singleView controlTitleAtIndex:(NSIndexPath *)indexPath
{
    return self.titleArray[indexPath.row];
}

#pragma mark - CGRadioViewDelegate
- (void)radioView:(CGRadioView *)radioView selectedAtIndex:(NSInteger)selectedIndex
{
    if (self.selectCallback) {
        
//        NSAssert([selectedControl isKindOfClass:[UIButton class]], @"必须是UIButton的子类");
        self.selectCallback((id)[self.contentView controlAtIndex:selectedIndex]);
    }
}

- (NSInteger)indexAtSelected:(UIControl *)selectedControl
{
    return [_contentView indexAtControl:selectedControl];
}
@end
