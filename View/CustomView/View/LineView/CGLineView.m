//
//  CGLineView.m
//  QuickAskCommunity
//
//  Created by DY on 16/8/12.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGLineView.h"

#import "UIView+CGAddConstraints.h"
#import "UIView+CGAddConstraintStatus.h"

@interface CGLineView ()
{
    NSMutableDictionary<NSNumber *, UIView *> *lineViews;
}

@end

@implementation CGLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentView    = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_contentView];
        _contentView.layoutPriorityForConstraint    = 999;
        [_contentView cg_autoEdgesInsetsZeroToSuperview];
        _contentView.layoutPriorityForConstraint    = UILayoutPriorityRequired;
    }
    return self;
}

- (void)setupLineView
{
    if (self.lineType & LineBoxTypeTop) {
        
    }
}

- (void)addLineViewWithType:(LineBoxType)type
{
    
}

- (void)removeLineViewWithType:(LineBoxType)type
{
    
}

#pragma mark - 设置属性

- (void)setLineType:(LineBoxType)lineType
{
    if (_lineType != lineType) {
        
        _lineType   = lineType;
        [self setupLineView];
    }
}

@end
