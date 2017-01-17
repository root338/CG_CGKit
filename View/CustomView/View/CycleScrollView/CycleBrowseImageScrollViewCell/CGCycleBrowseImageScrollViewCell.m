//
//  CGCycleBrowseImageScrollViewCell.m
//  QuickAskCommunity
//
//  Created by DY on 2017/1/9.
//  Copyright © 2017年 ym. All rights reserved.
//

#import "CGCycleBrowseImageScrollViewCell.h"

#import "UIView+CGAddConstraints.h"

@interface CGCycleBrowseImageScrollViewCell ()<UIScrollViewDelegate>
{
    BOOL didSetupConstraints;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign, readwrite) BOOL disableScrollZoom;
@property (nonatomic, strong, readwrite) UIImageView *imageView;

@end

@implementation CGCycleBrowseImageScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithScrollZoom:YES];
}

- (instancetype)initWithScrollZoom:(BOOL)scrollZoom
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _minimumZoomScale   = 1.0;
        _maximumZoomScale   = 2.0;
        
        _imageView  = [[UIImageView alloc] init];
        if (scrollZoom) {
            
            _scrollView = [[UIScrollView alloc] init];
            _scrollView.minimumZoomScale    = _minimumZoomScale;
            _scrollView.maximumZoomScale    = _maximumZoomScale;
            
            [_scrollView addSubview:_imageView];
            [self addSubview:_scrollView];
        }else {
            
            [self addSubview:_imageView];
        }
        _disableScrollZoom  = !scrollZoom;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (void)updateConstraints
{
    if (!didSetupConstraints) {
        
        if (_scrollView) {
            
            [_imageView cg_autoCenterToSuperview];
            [_imageView cg_attribute:NSLayoutAttributeHeight toItem:_scrollView relatedBy:NSLayoutRelationLessThanOrEqual constant:0];
            [_imageView cg_attribute:NSLayoutAttributeWidth toItem:_scrollView relatedBy:NSLayoutRelationLessThanOrEqual constant:0];
            [_scrollView cg_autoEdgesInsetsZeroToSuperview];
        }else {
            
            [_imageView cg_autoEdgesInsetsZeroToSuperview];
        }
        
        didSetupConstraints = YES;
    }
    [super updateConstraints];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
}

@end
