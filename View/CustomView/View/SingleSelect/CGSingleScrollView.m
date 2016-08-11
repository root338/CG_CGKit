//
//  CGTabScrollView.m
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CGSingleScrollView.h"

#import "CGRadioBaseView.h"
#import "CGSingleSliderView.h"

#import "UIView+CGSetupFrame.h"
#import "UIButton+AreaCalculate.h"
#import "UIView+CGAddConstraints.h"

@interface CGSingleScrollView ()
{
    BOOL didSetupConstraints;
}

@property (strong, nonatomic) UIScrollView *scrollView;

///加载选择的控件
@property (strong, nonatomic) CGRadioBaseView *contentView;

///加载的视图宽度集合
@property (strong, nonatomic) NSMutableArray *totalViewWidths;

@property (nonatomic, strong, readwrite) CGSingleSliderView *sliderView;
@end

@implementation CGSingleScrollView

@dynamic delegate;
@dynamic dataSource;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - setup view
- (void)setItemSpace:(CGFloat)itemSpace
{
    _itemSpace = itemSpace;
    self.contentView.itemSpace = itemSpace;
}

- (void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth = itemWidth;
    self.contentView.itemWidth = itemWidth;
}

- (CGRadioBaseView *)contentView
{
    if (_contentView) {
        return _contentView;
    }
    
    _contentView = [[CGRadioBaseView alloc] init];
    _contentView.itemHeight = self.height;
    [self setupRadioCallback];
    [[self scrollView] addSubview:_contentView];
    return _contentView;
}

- (CGRadioBaseView *)singleView
{
    return self.contentView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:_scrollView];
    
    
    return _scrollView;
}

- (CGSingleSliderView *)sliderView
{
    if (_sliderView) {
        return _sliderView;
    }
    
    _sliderView = [CGSingleSliderView createSingleSliderView];
    
    return _sliderView;
}

- (void)setDelegate:(id<CGRadioViewDelegate>)delegate
{
    self.contentView.delegate = delegate;
}

- (id<CGRadioViewDelegate>)delegate
{
    return self.contentView.delegate;
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

#pragma mark - update data
- (NSMutableArray *)totalViewWidths
{
    if (_totalViewWidths) {
        return _totalViewWidths;
    }
    
    _totalViewWidths = [NSMutableArray new];
    return _totalViewWidths;
}

- (void)setupRadioCallback
{
    __weak CGSingleScrollView *weakSelf = self;
    _contentView.didSetupViewFinish = ^(void) {
        
        CGSingleScrollView *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf updateRadioView];
        }
    };
    
    _contentView.didSelectedCallback = ^(void) {
        
        CGSingleScrollView *strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf updateScrollLocation];
        }
    };
}

- (void)updateScrollLocation
{
    
    //获取当前显示的滑动区域
    CGRect visibleRect = [self convertRect:self.bounds toView:self.contentView];
    CGRect afterVisibleRect = visibleRect;
    
    //获取当前选中按钮的坐标
    CGRect selectedViewFrame = self.contentView.selectControl.frame;
    
    //获取选中按钮下一个按钮的坐标
    UIView *nextView = [self.contentView selectedNextView];
    CGRect nextViewFrame = nextView.frame;
    
    //获取选中按钮上一个按钮的坐标
    UIView *previousView = [self.contentView selectedPreviousView];
    CGRect previousViewFrame = previousView.frame;
    
    if (!CGRectContainsRect(afterVisibleRect, nextViewFrame)) {
        //当选中按钮的下一个视图不在可视区域延伸可视区域坐标
        afterVisibleRect.origin.x = CGRectGetMaxX(nextViewFrame) - CGRectGetWidth(visibleRect);
    }
    
    if (!CGRectContainsRect(afterVisibleRect, previousViewFrame)) {
        //当选中按钮的上一个视图不在可视区域延伸可视区域坐标
        afterVisibleRect.origin.x = previousViewFrame.origin.x;
    }
    
    if (!CGRectContainsRect(afterVisibleRect, selectedViewFrame)) {
        //当选中按钮的区域不在移动后的可选区域内将选中按钮移动视图中间
        afterVisibleRect.origin.x = CGRectGetMaxX(selectedViewFrame) - CGRectGetWidth(selectedViewFrame);
    }
    
    [self.scrollView scrollRectToVisible:afterVisibleRect animated:YES];
    
    if (!self.hiddenSliderView) {
        
        if (!self.sliderView.superview) {
            [self.contentView addSubview:self.sliderView];
        }
        
        [self setupSliderLocation:self.contentView.selectControl];
    }
}

///设置滑块的位置
- (void)setupSliderLocation:(UIControl *)selectedControl
{
    
    CGFloat afterSlider = 0;
    
    switch (self.sliderView.sliderWidthType) {
        case CGSliderWidthTypeDefault:
        {
            afterSlider = selectedControl.width;
        }
            break;
        case CGSliderWidthTypeCustomWidth:
            
            afterSlider = self.sliderView.sliderWidth;
            break;
        case CGSliderWidthTypeEqualTitleWidth:
            
            if ([self.contentView.selectControl isKindOfClass:[UIButton class]]) {
                afterSlider = [(UIButton *)self.contentView.selectControl calculateButtonCurrentTitleSize].width + self.sliderView.leftSpace + self.sliderView.rightSpace;
            }else {
                
                CGDebugAssert(nil, @"视图没有标题");
            }
            
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        
        CGPoint center  = _sliderView.center;
        center.x        = selectedControl.center.x;
        self.sliderView.center  = center;
        self.sliderView.width   = afterSlider;
    }];
}

/**
 *  更新contentView视图中的内容
 *
 */
- (void)updateRadioView
{
    self.contentView.frame = CGRectMake(0, 0, self.contentView.totalWidths, self.height);
    self.scrollView.contentSize = self.contentView.size;
}

#pragma mark - update Constraints

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        [self.scrollView cg_autoEdgesInsetsZeroToSuperview];
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}
@end
