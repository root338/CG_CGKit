//
//  CGTabScrollView.m
//  iSpa
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 Chinamobo. All rights reserved.
//

#import "CGSingleControlView.h"


#import "CGSomeColorButton.h"
#import "CGSingleSliderView.h"
#import "CGSingleContentView.h"
#import "CGSingleBaseContentView.h"


#import "UIView+CGSetupFrame.h"
#import "UIButton+AreaCalculate.h"
#import "UIView+CGAddConstraints.h"
#import "UIView+CGAddConstraintStatus.h"
#import "UIView+CreateAutoLayoutTypeView.h"

#import "CGRadioTitleCellAppearance.h"

#import "CGPrintLogHeader.h"


@interface CGSingleControlView ()
{
    ///单选视图
    CGSingleContentView *_contentView;
    
    ///滑块视图
    CGSingleSliderView *_sliderView;
    
    //约束相关
    
    ///标识约束是否添加，避免重复添加
    BOOL didSetupConstraints;
    
    //滑块约束设置
    
    ///滑块水平约束
    NSLayoutConstraint *_sliderHConstraint;
    
    ///滑块左边与选择控件左边对齐
    NSLayoutConstraint *_sliderLeadingEqual;
    
    ///滑块宽度
    NSLayoutConstraint *_sliderWidthConstraint;
}

///查看当前视图按钮是否有选择控件
//@property (nonatomic, readonly) BOOL selectControlState;

/**
 选择控件主视图
 */
@property (readonly, nonatomic) CGSingleContentView* contentView;
@end

@implementation CGSingleControlView

@dynamic dataSource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - setting property
- (CGSingleContentView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    _contentView = [CGSingleContentView newAutoLayoutView];
    
    [self setupCallback];
    
    [self addSubview:_contentView];
    return _contentView;
}

- (CGSingleSliderView *)sliderView
{
    if (_sliderView) {
        return _sliderView;
    }
    
    _sliderView = [CGSingleSliderView createSingleSliderView];
    _sliderView.backgroundColor = self.contentView.titleAppearance.titleSelectColor;
    
    [self addSubview:_sliderView];
    return _sliderView;
}

- (void)setTitles:(NSArray *)titles
{
    if (![self.contentView.titleArray isEqualToArray:titles]) {
        
        self.contentView.titleArray = [NSMutableArray arrayWithArray:titles];
    }
}

- (NSArray *)titles
{
    return self.contentView.titleArray;
}

- (void)setDataSource:(id<CGSingleViewDataSource>)dataSource
{
    self.contentView.dataSource = dataSource;
}

- (id<CGSingleViewDataSource>)dataSource
{
    return self.contentView.dataSource;
}

#pragma mark - 选择标题外观设置
- (void)setTitleAppearance:(CGRadioTitleCellAppearance *)titleAppearance
{
    self.contentView.titleAppearance   = titleAppearance;
}

- (CGRadioTitleCellAppearance *)titleAppearance
{
    return self.contentView.titleAppearance;
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex
{
    [self contentView].defaultSelectedIndex = defaultSelectedIndex;
}

- (NSInteger)defaultSelectedIndex
{
    return [self contentView].defaultSelectedIndex;
}

#pragma mark -

///设置选择回调
- (void)setupCallback
{
    __weak CGSingleControlView *weakSelf = self;
    if (!_contentView.selectCallback) {
        _contentView.selectCallback = ^(UIControl *selectedControl) {
            
            CGSingleControlView *strongSelf = weakSelf;
            if (strongSelf) {
                _selectedControl = selectedControl;
                [strongSelf setupSliderLocation:selectedControl];
            }
        };
    }
}

- (void)setupSliderWidthConstraints
{
    switch (self.sliderView.sliderWidthType) {
        case CGSliderWidthTypeDefault:
        {
            [self setupSliderLeadingConstraint];
        }
            break;
        case CGSliderWidthTypeCustomWidth:
            
            [self setupSliderWidthConstraint:self.sliderView.sliderWidth];
            break;
        case CGSliderWidthTypeEqualTitleWidth:
            
            if ([self.selectedControl isKindOfClass:[UIButton class]]) {
                [self setupSliderWidthConstraint:[(UIButton *)self.selectedControl calculateButtonCurrentTitleSize].width];
            }else {
                
                CGDebugAssert(nil, @"视图没有标题");
            }
            
            break;
        default:
            break;
    }
}

- (void)setupSliderLeadingConstraint
{
    //删除固定宽度约束
    [self removeSliderWidthConstraint];
    
    //删除以前左边距相等约束
    [self removeSliderLeadingConstraint];
    
    _sliderLeadingEqual = [self.selectedControl cg_attribute:NSLayoutAttributeLeading
                                                      toItem:self.sliderView];
}

- (void)removeSliderLeadingConstraint
{
    if ([self.constraints containsObject:_sliderLeadingEqual]) {
        [self removeConstraint:_sliderLeadingEqual];
        _sliderLeadingEqual = nil;
    }
}

- (void)setupSliderWidthConstraint:(CGFloat)paramWidth
{
    [self removeSliderLeadingConstraint];
    
    if ([self.sliderView.constraints containsObject:_sliderWidthConstraint]) {
        //当约束已存在时直接设置新的宽度
        _sliderWidthConstraint.constant = paramWidth;
    }else {
        //否则创建滑块宽度约束
        _sliderWidthConstraint  = [self.sliderView cg_autoDimension:CGDimensionWidth fixedLength:paramWidth];
    }
}

- (void)removeSliderWidthConstraint
{
    if ([self.sliderView.constraints containsObject:_sliderWidthConstraint]) {
        [self.sliderView removeConstraint:_sliderWidthConstraint];
        _sliderWidthConstraint = nil;
    }
}

- (void)setupSliderHConstraint
{
    [self removeSliderHConstraint];
    
    if (self.selectedControl) {
        //设置滑块的水平中心等于选择的按钮的水平中心
        _sliderHConstraint  = [_sliderView cg_autoAxis:CGAxisVertical toSameAxisOfView:self.selectedControl];
    }else {
        
#ifdef DEBUG
        NSAssert1(nil, @"%s 已选控件不能为nil", __func__);
#endif
    }
}

- (void)removeSliderHConstraint
{
    //删除以前的滑块的水平中心约束
    if ([self.constraints containsObject:_sliderHConstraint]) {
        [self removeConstraint:_sliderHConstraint];
        _sliderHConstraint = nil;
    }
}

- (void)sendSelectedEvent:(UIControl *)selectedControl
{
    if ([self.delegate respondsToSelector:@selector(singleControl:selectedAtIndex:)]) {
        
        [self.delegate singleControl:self selectedAtIndex:[self.contentView indexAtSelected:selectedControl]];
    }
}

///设置滑块的位置
- (void)setupSliderLocation:(UIControl *)selectedControl
{
    //选择时回调
    [self sendSelectedEvent:selectedControl];
    
    //判断是否与按钮标题宽度相等
    //注意：这里按钮宽度是等宽的，自定义的宽度是恒定的（暂定，如果动态也不在这设置），所以这两者不用在选择控件变化时改变滑块宽度
    BOOL isSetupSliderWidth = (self.sliderView.sliderWidthType == CGSliderWidthTypeEqualTitleWidth);
    CGFloat afterSlider = 0;
    
    if (isSetupSliderWidth) {
        //当根据滑块标题设置滑块宽度时执行此方法计算按钮标题宽度
        if ([selectedControl isKindOfClass:[UIButton class]]) {
            afterSlider = [(UIButton *)selectedControl calculateButtonCurrentTitleSize].width;
        }else {
            CGDebugAssert(nil, @"无法计算标题");
        }
    }
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint center = _sliderView.center;
        center.x = selectedControl.center.x;
        self.sliderView.center = center;
        if (isSetupSliderWidth) {
            self.sliderView.width = afterSlider;
        }
    } completion:^(BOOL finished) {
        
        [self setupSliderHConstraint];
        [self setupSliderWidthConstraints];
    }];
}

#pragma mark - update layout

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        self.contentView.layoutPriorityForConstraint    = 900;
        [self.contentView cg_autoEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:CGLayoutEdgeBottom];
    
        self.contentView.layoutPriorityForConstraint    = UILayoutPriorityRequired;
        [self.contentView cg_attribute:NSLayoutAttributeBottom
                                toItem:self.sliderView
                             attribute:NSLayoutAttributeTop];
        [self.sliderView cg_autoConstrainToSuperviewAttribute:NSLayoutAttributeBottom];
        
        didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}
@end

