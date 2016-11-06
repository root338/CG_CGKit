//
//  CGTitlesTableView.m
//  TestCG_CGKit
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGTitlesTableView.h"

#import "CGRadioView.h"
#import "CGTitleRadioView.h"

#import "NSArray+CGAddConstraints.h"

#import "CGRadioViewAppearance.h"
#import "CGTitleRadioCellAppearance.h"

@interface CGTitlesTableView ()
{
    CGTitleRadioView    *_titleRadioView;
    CGRadioView         *_radioView;
}

@property (nonatomic, assign, readwrite) CGTitlesViewType titlesViewType;

@end

@implementation CGTitlesTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame titlesViewType:CGTitlesViewTypeViewHeader];
}

- (instancetype)initWithFrame:(CGRect)frame titlesViewType:(CGTitlesViewType)titlesViewType
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titlesViewType = titlesViewType;
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        if (self.delegate != nil) {
            [self reloadData];
        }
    }
}

- (void)reloadData
{
    [self setupContentView];
    
    
}

- (void)setupContentView
{
    if (!(_titleRadioView == nil || _radioView == nil)) {
        return ;
    }
    
    CGRadioViewAppearance *titleAppearance  = [self.delegate titlesViewAppearanceForTitlesTableView:self titlesViewType:self.titlesViewType];
    _titleRadioView = [[CGTitleRadioView alloc] initWithTitles:nil appearance:titleAppearance];
    
    CGRadioViewAppearance *contentAppearance   = [self.delegate titlesTableView:self tableViewAppearanceForIndex:self.currentIndex];
    _radioView  = [[CGRadioView alloc] initWithFrame:CGRectZero appearance:contentAppearance];
    
    [self addSubview:_titleRadioView];
    [self addSubview:_radioView];
    
    NSArray *views  = @[_titleRadioView, _radioView];
    [views cg_autoSetupVerticalSubviewsLayout];
}

@end
