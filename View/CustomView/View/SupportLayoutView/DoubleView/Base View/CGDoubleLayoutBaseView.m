//
//  CGDoubleLayoutBaseView.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGDoubleLayoutBaseView.h"

#import "UIView+CGAddConstraints.h"
#import "UIView+CGAddConstraintsForSubviews.h"

#import "CGTwoSubviewsConstraintsAppearance.h"

#import "CGPrintLogHeader.h"

@interface CGDoubleLayoutBaseView ()
{
    BOOL didSetupConstraints;
    //首次添加约束后，标识为YES，之后更新约束
    BOOL isUpdateConstraints;
    
    CGTwoSubviewsConstraintsAppearance *config;
}

@property (nonatomic, strong, readwrite) UIView *contentView;
@end

@implementation CGDoubleLayoutBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializationContentViewData];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initializationContentViewData];
}

- (void)initializationContentViewData
{
    _marginEdgeInsets           = UIEdgeInsetsZero;
    _firstTargetViewEdgeInsets  = UIEdgeInsetsZero;
    _secondTargetViewEdgeInsets = UIEdgeInsetsZero;
    _targetViewsBetweenSapce    = 0;
    
    _firstItemSize              = CGSizeZero;
    _secondItemSize             = CGSizeZero;
    
    config          = [[CGTwoSubviewsConstraintsAppearance alloc] init];
    _contentView    = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        [self setupViewConstraints];
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setupViewConstraints
{
    config.firstView    = [self cg_layoutFirstTargetView];
    config.secondView   = [self cg_layoutSecondTargetView];
    [UIView cg_autoSetUpdate:isUpdateConstraints forConstraints:^{
        
        [self.contentView cg_autoEdgesToSuperviewEdgesWithInsets:self.marginEdgeInsets];
        [self.contentView cg_autoTwoSubviewsWithConfig:config];
    }];
    
    if (!isUpdateConstraints) {
        isUpdateConstraints = YES;
    }
}

- (void)setupUpdateConstraints
{
    didSetupConstraints = NO;
    [self setNeedsUpdateConstraints];
}

#pragma mark - CGDoubleLayoutDelegate
- (UIView *)cg_layoutFirstTargetView
{
    return self;
}

- (UIView *)cg_layoutSecondTargetView
{
    return self;
}

#pragma mark - 设置属性
- (void)setTargetViewsBetweenSapce:(CGFloat)targetViewsBetweenSapce
{
    if (_targetViewsBetweenSapce != targetViewsBetweenSapce) {
        
        _targetViewsBetweenSapce    = targetViewsBetweenSapce;
        config.firstViewToSecondViewSpace   = targetViewsBetweenSapce;
        [self setupUpdateConstraints];
    }
}

- (void)setBetweenSpaceRelation:(NSLayoutRelation)betweenSpaceRelation
{
    if (_betweenSpaceRelation != betweenSpaceRelation) {
        
        _betweenSpaceRelation   = betweenSpaceRelation;
        config.betweenSpaceLayoutRelation   = betweenSpaceRelation;
        [self setupUpdateConstraints];
    }
}

- (void)setMarginEdgeInsets:(UIEdgeInsets)marginEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(marginEdgeInsets, _marginEdgeInsets)) {
        _marginEdgeInsets   = marginEdgeInsets;
        [self setupUpdateConstraints];
    }
}

- (void)setFirstTargetViewEdgeInsets:(UIEdgeInsets)firstTargetViewEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(firstTargetViewEdgeInsets, _firstTargetViewEdgeInsets)) {
        _firstTargetViewEdgeInsets  = firstTargetViewEdgeInsets;
        config.firstViewEdgeInsets  = firstTargetViewEdgeInsets;
        [self setupUpdateConstraints];
    }
}

- (void)setSecondTargetViewEdgeInsets:(UIEdgeInsets)secondTargetViewEdgeInsets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(secondTargetViewEdgeInsets, _secondTargetViewEdgeInsets)) {
        _secondTargetViewEdgeInsets = secondTargetViewEdgeInsets;
        config.secondViewEdgeInsets = secondTargetViewEdgeInsets;
        [self setupUpdateConstraints];
    }
}

- (void)setFirstTargetViewExcludingEdge:(CGLayoutOptionEdge)firstTargetViewExcludingEdge
{
    if (_firstTargetViewExcludingEdge != firstTargetViewExcludingEdge) {
        _firstTargetViewExcludingEdge = firstTargetViewExcludingEdge;
        config.firstViewExcludingOptionEdge = firstTargetViewExcludingEdge;
        [self setupUpdateConstraints];
    }
}

- (void)setSecondTargetViewExcludingEdge:(CGLayoutOptionEdge)secondTargetViewExcludingEdge
{
    if (_secondTargetViewExcludingEdge != secondTargetViewExcludingEdge) {
        _secondTargetViewExcludingEdge = secondTargetViewExcludingEdge;
        config.secondViewExcludingOptionEdge = secondTargetViewExcludingEdge;
        [self setupUpdateConstraints];
    }
}

- (void)setFirstItemSize:(CGSize)firstItemSize
{
    if (!CGSizeEqualToSize(firstItemSize, _firstItemSize)) {
        _firstItemSize          = firstItemSize;
        config.firstViewSize    = firstItemSize;
        [self setupUpdateConstraints];
    }
}

- (void)setSecondItemSize:(CGSize)secondItemSize
{
    if (!CGSizeEqualToSize(secondItemSize, _secondItemSize)) {
        _secondItemSize         = secondItemSize;
        config.secondViewSize   = secondItemSize;
        [self setupUpdateConstraints];
    }
}

- (void)setAlignment:(CGAlignmentType)alignment
{
    if (_alignment != alignment) {
        _alignment  = alignment;
        config.alignmentType    = alignment;
        
        [self.contentView removeConstraints:self.contentView.constraints];
        [self setupUpdateConstraints];
    }
}

- (void)setFirstViewCenter:(BOOL)firstViewCenter
{
    if (_firstViewCenter != firstViewCenter) {
        _firstViewCenter = firstViewCenter;
        config.firstViewCenter = firstViewCenter;
        [self.contentView removeConstraints:self.contentView.constraints];
        [self setupUpdateConstraints];
    }
}

- (void)setSecondViewCenter:(BOOL)secondViewCenter
{
    if (_secondViewCenter != secondViewCenter) {
        _secondViewCenter = secondViewCenter;
        config.secondViewCenter = secondViewCenter;
        [self.contentView removeConstraints:self.contentView.constraints];
        [self setupUpdateConstraints];
    }
}

@end
