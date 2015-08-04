//
//  HorizontalSingleView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "HorizontalSingleView.h"
#import "UIButton+AreaCalculate.h"

@interface HorizontalSingleView ()
{
    
}
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *sliderView;

@end

@implementation HorizontalSingleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.appearance.lineType != DDrawLineTypeNone) {
        
        self.lineColor = self.appearance.lineColor;
        self.lineWidth = @(self.appearance.lineWidth);
        
        UIBezierPath *bezierPath = [self createBoxType:self.appearance.lineType edge:self.appearance.lineEdgeInsets];
        [bezierPath stroke];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 
- (UIButton *)contentViewAtIndex:(NSInteger)index
{
    __block UIButton *button = nil;
    [self.contentView.subviews enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
        if (index == obj.tag) {
            button = obj;
            *stop = YES;
        }
    }];
    return button;
}

#pragma mark - 页面设置
/**
 *  更新视图
 */
- (void)updateContentView
{
    //防止短时间内重复更新
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(updateContentView) object:nil];
    
    //当没有添加视图时，添加内容视图、滑块视图
    if (!self.contentView.superview) {
        
        [self addSubview:self.contentView];
    }
    if (!self.sliderView.superview) {
        
        [self addSubview:self.sliderView];
    }
    
    self.sliderView.backgroundColor = self.appearance.sliderColor;
    
    
    //选择内容控件内部设置
    /////////
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *button = nil;
        if (self.setupSelecteView) {
            
            button = self.setupSelecteView(idx, obj);
        }else if (self.selecteViewClass){
            
            button = [self.selecteViewClass new];
            [button setTitle:obj forState:UIControlStateNormal];
            
        }
        if (button) {
            
            button.tag = idx;
            [button addTarget:self action:@selector(handleContentViewForButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:button];
        }
    }];
    
    //更新视图时，选择默认选择控件
    [self.selectedButton setSelected:YES];
    
    if (self.appearance.backgroundColor) {
        self.backgroundColor = self.appearance.backgroundColor;
    }
    
    //更新视图
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIEdgeInsets margin = self.appearance.edgeInsetForContentView;
    CGSize viewSize = self.bounds.size;
    
    self.contentView.frame = CGRectMake(margin.left, margin.top, viewSize.width - (margin.left + margin.right), viewSize.height - (margin.top + margin.bottom));
    
    CGFloat width = (CGRectGetWidth(self.contentView.bounds) - (self.appearance.spaceForButtons * (self.titles.count - 1)));
    CGFloat height = CGRectGetHeight(self.contentView.bounds);
    
    CGFloat buttonWidth = self.titles.count ? width / self.titles.count : 0;
    CGFloat buttonHeight = height;
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    for (UIView *subview in self.contentView.subviews) {
        
        subview.frame = CGRectMake(originX, originY, buttonWidth, buttonHeight);
        originX += buttonWidth + self.appearance.spaceForButtons;
    }
    
    [self updateSliderViewLocationIsAnmation:NO];
}

- (void)updateSliderViewLocationIsAnmation:(BOOL)isAnmation
{

    CGRect frame = self.sliderView.frame;
    CGFloat sliderWidth = 0;
    
    //设置滑块的宽度
    switch (self.appearance.sliderType) {
        case HorizontalSingleSliderTypeTitle:
            sliderWidth = [self.selectedButton calculateButtonCurrentTitleSize].width;
            break;
        case HorizontalSingleSliderTypeCustom:
            sliderWidth = self.appearance.sliderSize.width;
            break;
        default:
            sliderWidth = self.selectedButton.bounds.size.width;
            break;
    }
    
    //设置滑块的 X 坐标，相对于选择按钮中心坐标减去滑块二分之一的宽度
    CGPoint selectButtonPoint = [self.contentView convertPoint:self.selectedButton.center fromView:self];
    CGFloat sliderOriginX = selectButtonPoint.x - sliderWidth / 2;
    
    frame = CGRectMake(sliderOriginX, self.bounds.size.height - self.appearance.sliderSize.height, sliderWidth, self.appearance.sliderSize.height);
    
    if (isAnmation) {
        [UIView animateWithDuration:.3 animations:^{
            self.sliderView.frame = frame;
        } completion:^(BOOL finished) {

        }];
    }else {
        self.sliderView.frame = frame;
    }
}

#pragma mark - 滑块位置更新
- (void)updateSliderViewContentOffset:(CGFloat)offset
{
    CGRect frame = self.sliderView.frame;
    
    frame.origin.x += offset;

    self.sliderView.frame = frame;
}

#pragma mark - 按钮事件
- (void)handleContentViewForButtonAction:(UIButton *)sender
{
    if (self.selectedIndex != sender.tag) {
        self.selectedIndex = sender.tag;
    }
}

#pragma mark - 设置属性
- (void)setTitles:(NSArray *)titles
{
    if (![_titles isEqualToArray:titles]) {
        _titles = titles;
        
        [self performSelector:@selector(updateContentView) withObject:nil afterDelay:0];
    }
}

- (UIView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[UIView alloc] init];
    
    return self.contentView;
}

- (UIView *)sliderView
{
    if (_sliderView) {
        return _sliderView;
    }
    
    _sliderView = [[UIView alloc] init];
    
    return _sliderView;
}

- (UIButton *)selectedButton
{
    return [self contentViewAtIndex:self.selectedIndex];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex) {
        
        //取消之前选择的控件
        [self.selectedButton setSelected:NO];
        
        //设置新的选择控件
        _selectedIndex = selectedIndex;
        [self.selectedButton setSelected:YES];
        [self updateSliderViewLocationIsAnmation:YES];
        
        //回调通知
        if (self.didSelectedChangeCallback) {
            self.didSelectedChangeCallback(selectedIndex);
        }
    }
}
@end
