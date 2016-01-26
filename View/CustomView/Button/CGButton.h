//
//  CGButton.h
//  QuickAskCommunity
//
//  Created by DY on 16/1/15.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseButton.h"
#import "CGButtonAlignStyleHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  重写UIButton布局的子类，方便图像和标题的布局
 *  @param UIButton 的子类
 *  @param 功能：  1. 方便设置图像和标题的对齐样式，图像和标题之间的间距，外边界的间距
                  2. titleEdgeInsets, imageEdgeInsets两个属性被无效化
 *
 */
@interface CGButton : CGBaseButton

#pragma mark - 标题、图片布局设置
/** 图片标题的对齐方式 */
@property (nonatomic, assign) CGButtonStyle buttonStyle;
/** 图片标题之间的间距 */
@property (nonatomic, assign) CGFloat space;
/** 可设置的最大大小 */
//@property (nonatomic, assign) CGSize maxSize;
/** contentView距离外边框之间的间距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;
/** 标题和图片的对齐方式 */
@property (nonatomic, assign) CGButtonContentAlignment contentAlignment;
//@property (nonatomic, assign) UIOffset imageViewOffset;

- (void)sizeToFit;
@end
NS_ASSUME_NONNULL_END