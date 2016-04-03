//
//  CGPhotoCollectionViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoCollectionViewCell.h"

#import "UIView+CGAddConstraints.h"

#import "ALAsset+CGProperty.h"

@interface CGPhotoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CGPhotoCollectionViewCell

- (void)setupCollectionViewCellContentWithData:(id)paramData
{
    if ([paramData isKindOfClass:[ALAsset class]]) {
        
        ALAsset *asset          = paramData;
        self.imageView.image    = [asset cg_assetImageWithType:CGAssetImageTypeSquareThumbnails];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame    = self.bounds;
}

#pragma mark - 设置属性

- (UIImageView *)imageView
{
    if (_imageView) {
        return _imageView;
    }
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
    return _imageView;
}

@end
