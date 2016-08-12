//
//  CGLineView.m
//  QuickAskCommunity
//
//  Created by DY on 16/8/12.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGLineView.h"

#import "UIView+CGAddConstraints.h"

@interface CGLineView ()
{
    
    NSMutableDictionary<NSNumber *, UIView *> *_lineViews;
}

@property (nonatomic, strong) NSArray<NSNumber *> *lineTypeKeys;

@end

@implementation CGLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _contentView    = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_contentView];
        
        [_contentView cg_autoSetPriority:999 forConstraints:^(UIView * _Nonnull makeView) {
            [makeView cg_autoEdgesInsetsZeroToSuperview];
        }];
    }
    return self;
}

- (void)setupLineView
{
    if (!self.lineType && !_lineViews.count) {
        return;
    }
    
    [self.lineTypeKeys enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LineBoxType lineType    = obj.integerValue;
        if (self.lineType & lineType) {
            [self addLineViewWithType:lineType key:obj];
        }else {
            [self removeLineViewWithType:lineType key:obj];
        }
    }];
    
    [self layoutIfNeeded];
}

- (void)addLineViewWithType:(LineBoxType)type key:(NSNumber *)key
{
    
    UIView *lineView    = [_lineViews objectForKey:key];
    if (lineView) {
        return;
    }
    
    lineView    = [[UIView alloc] init];
    lineView.backgroundColor    = self.lineColor;
    [self addSubview:lineView];
    
    CGDimension dimension;
    CGLayoutEdge lineViewEdge;
    CGLayoutEdge contentViewEdge;
    
    switch (type) {
        case LineBoxTypeTop:
        {
            dimension       = CGDimensionHeight;
            lineViewEdge    = CGLayoutEdgeBottom;
            contentViewEdge = CGLayoutEdgeTop;
        }
            break;
        case LineBoxTypeLeft:
        {
            dimension       = CGDimensionWidth;
            lineViewEdge    = CGLayoutEdgeTrailing;
            contentViewEdge = CGLayoutEdgeLeading;
        }
            break;
        case LineBoxTypeBottom:
        {
            dimension       = CGDimensionHeight;
            lineViewEdge    = CGLayoutEdgeTop;
            contentViewEdge = CGLayoutEdgeBottom;
        }
            break;
        case LineBoxTypeRight:
        {
            dimension       = CGDimensionWidth;
            lineViewEdge    = CGLayoutEdgeLeading;
            contentViewEdge = CGLayoutEdgeTrailing;
        }
            break;
        default:
            break;
    }
    
    [lineView cg_autoDimension:dimension fixedLength:self.lineWidth];
    [lineView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero
                                       excludingEdge:lineViewEdge];
    [lineView cg_attribute:(NSLayoutAttribute)lineViewEdge toItem:self.contentView attribute:(NSLayoutAttribute)contentViewEdge];
}

- (void)removeLineViewWithType:(LineBoxType)type key:(NSNumber *)key
{
    UIView *lineView    = [_lineViews objectForKey:key];
    if (lineView) {
        [lineView removeFromSuperview];
        [_lineViews removeObjectForKey:key];
    }
}

#pragma mark - 设置属性

- (NSArray<NSNumber *> *)lineTypeKeys
{
    if (_lineTypeKeys) {
        return _lineTypeKeys;
    }
    
    _lineTypeKeys = @[
                      @(LineBoxTypeTop),
                      @(LineBoxTypeLeft),
                      @(LineBoxTypeBottom),
                      @(LineBoxTypeRight),
                      ];
    
    return _lineTypeKeys;
}

- (void)setLineType:(LineBoxType)lineType
{
    if (_lineType != lineType) {
        
        _lineType   = lineType;
        [self setupLineView];
    }
}

@end
