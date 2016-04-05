//
//  CGBrowsePhotoCollectionViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowsePhotoCollectionViewCell.h"
//#import "CGImageView.h"

#import "UIScrollView+CGCreate.h"

#import "ALAsset+CGProperty.h"

@interface CGBrowsePhotoCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIImageView *imageView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CGBrowsePhotoCollectionViewCell

- (void)setupCollectionViewCellContentWithData:(id)paramData
{
    if ([paramData isKindOfClass:[ALAsset class]]) {
        
        ALAsset *asset          = paramData;
        self.imageView.image    = [asset cg_assetImageWithType:CGAssetImageTypeSquareThumbnails];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame   = self.bounds;
    self.imageView.frame    = self.scrollView.bounds;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

#pragma mark - 设置属性

- (UIImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode  = UIViewContentModeScaleAspectFit;
//    _imageView.maxZoomScale                 = 3;
//    _imageView.isAutoImageViewContentMode   = YES;
    [self.scrollView addSubview:_imageView];
    
    return _imageView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    
    _scrollView = [UIScrollView cg_createWithScrollViewWithShowScrollIndicator:NO];
    [self addSubview:_scrollView];
    _scrollView.delegate    = self;
    
    return _scrollView;
}

@end
