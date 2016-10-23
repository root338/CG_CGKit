//
//  CGTitleRadioCollectionViewCell.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CGTitleRadioCellAppearance;


@interface CGTitleRadioCollectionViewCell : CGRadioCollectionViewCell

@property (nullable, nonatomic, strong, readonly) UILabel *titleLabel;

- (void)setupCollectionViewCellContentWithData:(CGTitleRadioCellAppearance *)appearance;

@end

NS_ASSUME_NONNULL_END
