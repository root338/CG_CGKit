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
#import "UIView+CGAddConstraints.h"

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
        self.imageView.image    = [asset cg_assetImageWithType:CGAssetImageTypeAspectRatioThumbnails];
        [asset cg_assetImageWithType:CGAssetImageTypeFullScreenImage completion:^(UIImage * _Nullable didLoadImage) {
            self.imageView.image    = didLoadImage;
        }];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
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
    _scrollView.delegate                = self;
    _scrollView.maximumZoomScale        = 3.0;
    [_scrollView cg_autoEdgesInsetsZeroToSuperview];
    
    return _scrollView;
}

@end
