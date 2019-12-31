//
//  HorizontalSingleView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/17.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "HorizontalSingleView.h"
#import "UIButton+AreaCalculate.h"

#import "UIView+CGSetupFrame.h"
#import "UIView+CG_CGAreaCalculate.h"

@interface HorizontalSingleView ()
{
    BOOL isChangeValue;
}
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *sliderView;

@end

@implementation HorizontalSingleView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (self.appearance.lineType != CGLineBoxTypeNone) {
        
        self.lineColor = self.appearance.lineColor;
        self.lineWidth = self.appearance.lineWidth;
        
        UIBezierPath *bezierPath = [self createBoxType:self.appearance.lineType edge:self.appearance.lineEdgeInsets];
        [bezierPath stroke];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
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

- (UIButton *)buttonAtIndex:(NSInteger)index
{
    return [self contentViewAtIndex:index];
}

#pragma mark - 页面设置

- (BOOL)canReloadData {
    CGRect frame = self.frame;
    return _titles.count > 0 && CGRectGetHeight(frame) > CGFLOAT_MIN && CGRectGetWidth(frame) > CGFLOAT_MIN && self.window != nil;
}

- (void)setNeedReloadData {
    isChangeValue = YES;
    if (![self canReloadData]) {
        return;
    }
    [self reloadDataIfNeeded];
}

- (BOOL)reloadDataIfNeeded {
    if (!isChangeValue || ![self canReloadData]) {
        return NO;
    }
    [self updateContentView];
    [self updateAllSubviewsLayout];
    isChangeValue = NO;
    return YES;
}

/**
 *  更新视图
 */
- (void)updateContentView
{
    //当没有添加视图时，添加内容视图、滑块视图
    if (!self.contentView.superview) {
        
        [self addSubview:self.contentView];
    }
    if (!self.sliderView.superview) {
        
        [self addSubview:self.sliderView];
    }
    
    self.sliderView.backgroundColor = self.appearance.sliderColor;
    self.sliderView.layer.cornerRadius = self.appearance.sliderCornerRadius;
    
    //选择内容控件内部设置
    /////////
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *button = nil;
        
        if (self.setupSelecteView) {
            
            button = self.setupSelecteView(idx, obj);
        }else {
            
            NSString *title = nil;
            if ([obj isKindOfClass:[NSString class]]) {
                title = obj;
            }else {
                NSAssert(self.setupButtonTitle, @"需要设置setupButtonTitle来帮助视图设置按钮标题");
                title = self.setupButtonTitle(idx, obj);
            }
            
            if (self.selecteViewClass){
            
                button = [self.selecteViewClass new];
                [button setTitle:title forState:UIControlStateNormal];
            
            }else {
            
                button = [UIButton buttonWithType:self.appearance.buttonType];
                [button setTitle:title forState:UIControlStateNormal];
            }
            
            [self.appearance.titleColors enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, UIColor * _Nonnull obj, BOOL * _Nonnull stop) {
                [button setTitleColor:obj forState:key.unsignedIntegerValue];
            }];
            
            button.titleLabel.font = self.appearance.titleFont;
        }
        
        if (self.setupButtonAppearance) {
            self.setupButtonAppearance(button);
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
    if ([self.delegate respondsToSelector:@selector(didFinishUpdateSingleView:)]) {
        [self.delegate didFinishUpdateSingleView:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (![self reloadDataIfNeeded]) {
        [self updateAllSubviewsLayout];
    }
    [super layoutSubviews];
}

- (void)updateSliderViewLocationIsAnmation:(BOOL)isAnmation
{

    if (!self.selectedButton) {
        return;
    }
    CGRect frame = self.sliderView.frame;
    CGFloat sliderWidth = 0;
    
    //设置滑块的宽度
    switch (self.appearance.sliderType) {
        case HorizontalSingleSliderTypeTitle:
        case HorizontalSingleSliderTypeTitleInsetsEdge:
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
    CGPoint selectButtonPoint = [self.contentView convertPoint:self.selectedButton.center toView:self];
    CGFloat sliderOriginX = selectButtonPoint.x - sliderWidth / 2;
    if (self.appearance.sliderType == HorizontalSingleSliderTypeTitleInsetsEdge) {
        
        sliderOriginX   -= self.appearance.sliderLeftSpaceInsets;
        sliderWidth     += self.appearance.sliderLeftSpaceInsets + self.appearance.sliderRightSpaceInsets;
    }
    
    frame = CGRectMake(sliderOriginX, self.bounds.size.height - self.appearance.sliderSize.height - self.appearance.sliderBottom, sliderWidth, self.appearance.sliderSize.height);
    
    if (isAnmation) {
        [UIView animateWithDuration:.3 animations:^{
            self.sliderView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }else {
        self.sliderView.frame = frame;
    }
}

- (void)updateAllSubviewsLayout {
    UIEdgeInsets margin = self.appearance.edgeInsetForContentView;
    
    self.contentView.frame = CG_CGFrameWithMaxFrame(self.bounds, margin);
    if (self.appearance.style == HorizontalSingleViewStyleDefault) {
        
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
    }else if (self.appearance.style == HorizontalSingleViewStyleValue1) {
        
        CGFloat width = self.contentView.width;
        CGFloat height = self.contentView.height;
        
        CGFloat spaceForButton = 0;
        UIEdgeInsets buttonMarginEdgeInsets = margin;
        
        if (self.titles.count > 1) {
            
            CGFloat subviewTotalWidth = 0;
            
            for (UIView *subview in self.contentView.subviews) {
                [subview sizeToFit];
                subviewTotalWidth += subview.width;
            }
            if (subviewTotalWidth > width) {
                if (subviewTotalWidth <= self.width) {
                    CGFloat marginTotalLenght = self.width - subviewTotalWidth;
                    UIEdgeInsets tempMargin = margin;
                    if (margin.left == 0 && margin.right != 0) {
                        tempMargin.right = marginTotalLenght;
                    }else if (margin.left != 0 && margin.right == 0) {
                        tempMargin.left = marginTotalLenght;
                    }else if (margin.left != 0 && margin.right != 0) {
                        CGFloat scale = margin.left / margin.right;
                        tempMargin.right = subviewTotalWidth / (scale + 1);
                        tempMargin.left = subviewTotalWidth - tempMargin.right;
                    }
                    self.contentView.frame = CG_CGFrameWithMaxFrame(self.bounds, tempMargin);
                    buttonMarginEdgeInsets = tempMargin;
                }
                
            }else {
                
                spaceForButton = (width - subviewTotalWidth) / (self.titles.count - 1);
            }
        }
        
        CGFloat originX = 0;
        CGFloat originY = 0;
        
        for (UIView *subview in self.contentView.subviews) {
            
            subview.frame = CGRectMake(originX, originY, subview.width, height);
            originX += subview.frame.size.width + spaceForButton;
        }
    }
    
    [self updateSliderViewLocationIsAnmation:NO];
}

#pragma mark - 滑块位置更新
- (void)updateSliderViewContentOffset:(CGFloat)offset
{
    CGRect frame = self.sliderView.frame;
    
    frame.origin.x += offset;

    self.sliderView.frame = frame;
}

- (void)updateSelctedView:(NSInteger)selectedIndex
{
    //取消之前选择的控件
    [self.selectedButton setSelected:NO];
    
    //设置新的选择控件
    _selectedIndex = selectedIndex;
    [self.selectedButton setSelected:YES];
    [self updateSliderViewLocationIsAnmation:YES];
}

#pragma mark - 按钮事件
- (void)handleContentViewForButtonAction:(UIButton *)sender
{
    if (self.selectedIndex != sender.tag) {
        
        [self updateSelctedView:sender.tag];
        //回调通知
        if (self.didSelectedChangeCallback) {
            self.didSelectedChangeCallback(sender.tag);
        }
    }
}

- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self reloadDataIfNeeded];
}

#pragma mark - 设置属性

- (void)setAppearance:(HorizontalSingleAppearance *)appearance
{
    _appearance = appearance;
    [self setNeedReloadData];
}

- (void)setTitles:(NSArray *)titles
{
    if (titles != nil && [_titles isEqualToArray:titles]) {
        return;
    }
    _titles = titles;
    [self setNeedReloadData];
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
        
        [self updateSelctedView:selectedIndex];
    }
}
@end
