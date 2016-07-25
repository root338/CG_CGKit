//
//  CGDoubleLayoutBaseView.m
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGDoubleLayoutBaseView.h"

#import "UIView+CGAddConstraints.h"

#import "CGPrintLogHeader.h"

@interface CGDoubleLayoutBaseView ()
{
    BOOL didSetupConstraints;
}

@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation CGDoubleLayoutBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentView    = [[UIView alloc] init];
        [self addSubview:_contentView];
        
        [self performSelector:@selector(delaySetupConstraints)
                   withObject:nil
                   afterDelay:0];
    }
    return self;
}

- (void)delaySetupConstraints
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.disableRunLoopSetupConstraints) {
        return;
    }
    [self setupViewConstraints];
}

- (void)setupViewConstraints
{
    UIView *firstTargetView     = [self cg_layoutFirstTargetView];
    UIView *secondTargetView    = [self cg_layoutSecondTargetView];
    
    BOOL firstItemAvailable     = firstTargetView.superview && firstTargetView != self;
    BOOL secondItemAvailable    = secondTargetView.superview && secondTargetView != self;
    if (!firstItemAvailable || !secondItemAvailable) {
        return;
    }
    
    if (!didSetupConstraints) {
        didSetupConstraints = YES;
    }else {
        firstTargetView.isUpdateAddConstraint   = YES;
        secondTargetView.isUpdateAddConstraint  = YES;
    }
    
    [self.contentView cg_autoEdgesToSuperviewEdgesWithInsets:self.marginEdgeInsets];
    CGLayoutEdge firstExcludingEdge, secondExcludingEdge;
    if (self.alignment == CGAlignmentTypeHorizontal) {
        
        firstExcludingEdge  = CGLayoutEdgeTrailing;
        secondExcludingEdge = CGLayoutEdgeLeading;
    }else  {
        
        firstExcludingEdge  = CGLayoutEdgeBottom;
        secondExcludingEdge = CGLayoutEdgeTop;
    }
    
    if (!CGSizeEqualToSize(CGSizeZero, self.firstItemSize)) {
        [firstTargetView cg_autoSetupViewSize:self.firstItemSize];
    }
    
    if (!CGSizeEqualToSize(CGSizeZero, self.secondItemSize)) {
        [secondTargetView cg_autoSetupViewSize:self.secondItemSize];
    }
    
    [firstTargetView cg_attribute:(NSLayoutAttribute)firstExcludingEdge
                           toItem:secondTargetView
                        attribute:(NSLayoutAttribute)secondExcludingEdge
                         constant:self.targetViewsBetweenSapce];
    [firstTargetView cg_autoEdgesToSuperviewEdgesWithInsets:self.firstTargetViewEdgeInsets excludingEdge:firstExcludingEdge];
    [secondTargetView cg_autoEdgesToSuperviewEdgesWithInsets:self.secondTargetViewEdgeInsets excludingEdge:secondExcludingEdge];
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


@end
