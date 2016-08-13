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
    //线视图的边距
    NSMutableDictionary<NSNumber *, NSValue *> *_lineViewsEdgeInsets;
    //线视图
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

#pragma mark - 设置样式
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets lineType:(LineBoxType)lineType
{
    if (!lineType) {
        return;
    }
    
    if (!_lineViewsEdgeInsets) {
        _lineViewsEdgeInsets    = [NSMutableDictionary dictionary];
    }
    
    NSValue *edgeInsetsValue    = [NSValue valueWithUIEdgeInsets:edgeInsets];
    [self.lineTypeKeys enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LineBoxType lineBoxType = obj.integerValue;
        if (lineType & lineBoxType) {
            [_lineViewsEdgeInsets setObject:edgeInsetsValue forKey:obj];
        }
    }];
}

#pragma mark - 设置 线视图
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
    if (!_lineViews) {
        _lineViews  = [NSMutableDictionary dictionaryWithObject:lineView forKey:key];
    }else {
        [_lineViews setObject:lineView forKey:key];
    }
    
    CGDimension     dimension;
    CGLayoutEdge    lineViewEdge;
    CGFloat         constant;
    
    NSValue *edgeInsetsValue  = [_lineViewsEdgeInsets objectForKey:key];
    UIEdgeInsets edgeInsets;
    if (edgeInsetsValue) {
        edgeInsets  = [edgeInsetsValue UIEdgeInsetsValue];
    }else {
        edgeInsets  = UIEdgeInsetsZero;
    }
    
    switch (type) {
        case LineBoxTypeTop:
        {
            dimension       = CGDimensionHeight;
            lineViewEdge    = CGLayoutEdgeBottom;
            constant        = edgeInsets.bottom;
        }
            break;
        case LineBoxTypeLeft:
        {
            dimension       = CGDimensionWidth;
            lineViewEdge    = CGLayoutEdgeTrailing;
            constant        = edgeInsets.right;
        }
            break;
        case LineBoxTypeBottom:
        {
            dimension       = CGDimensionHeight;
            lineViewEdge    = CGLayoutEdgeTop;
            constant        = edgeInsets.top;
        }
            break;
        case LineBoxTypeRight:
        {
            dimension       = CGDimensionWidth;
            lineViewEdge    = CGLayoutEdgeLeading;
            constant        = edgeInsets.left;
        }
            break;
        default:
            break;
    }
    
    [lineView cg_autoDimension:dimension fixedLength:self.lineWidth];
    [lineView cg_autoEdgesToSuperviewEdgesWithInsets:edgeInsets
                                       excludingEdge:lineViewEdge];
    [lineView cg_autoInverseAttribute:lineViewEdge
                               toItem:self.contentView
                             constant:constant];
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
