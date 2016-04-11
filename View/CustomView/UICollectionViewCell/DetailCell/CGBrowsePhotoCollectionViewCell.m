//
//  CGBrowsePhotoCollectionViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBrowsePhotoCollectionViewCell.h"
#import "CGImageView.h"

#import "UIView+CGAddConstraints.h"

#import "ALAsset+CGProperty.h"

@interface CGBrowsePhotoCollectionViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) CGImageView *photoImageView;

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

- (void)addSingleTapTarget:(id)target action:(SEL)action
{
    [self.photoImageView addSingleTapTarget:target action:action];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - 设置属性

- (UIImageView *)imageView
{
    return self.photoImageView.imageView;
}

- (CGImageView *)photoImageView
{
    if (_photoImageView) {
        return _photoImageView;
    }
    
    _photoImageView = [[CGImageView alloc] init];
    _photoImageView.imageScrollView.maximumZoomScale    = 3;
    [self addSubview:_photoImageView];
    
    [_photoImageView cg_autoEdgesInsetsZeroToSuperview];
    
    return _photoImageView;
}

@end
