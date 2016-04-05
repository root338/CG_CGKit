//
//  CGBrowsePhotoCollectionViewCell.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/5.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
//@class CGImageView;

/** 图片浏览的cell */
@interface CGBrowsePhotoCollectionViewCell : CGCollectionViewCell

@property (nonatomic, strong, readonly) UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END