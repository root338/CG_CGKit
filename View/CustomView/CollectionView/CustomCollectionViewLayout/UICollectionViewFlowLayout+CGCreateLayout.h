//
//  UICollectionViewFlowLayout+CGCreateLayout.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/2.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 快捷创建UICollectionViewFlowLayout */
@interface UICollectionViewFlowLayout (CGCreateLayout)

/** 创建collectionView的布局类 */
+ (instancetype)cg_createWithWidth:(CGFloat)width count:(NSInteger)count space:(CGFloat)space;

/**
 *  创建collectionView的布局类
 *
 *  @param width  执行的宽度
 *  @param count  横向的数量
 *  @param space  cell之间横向间距，cell的纵向间距
 *  @param insets section之间的外边距
 *
 *  @return 返回collectionView的布局类
 */
+ (instancetype)cg_createWithWidth:(CGFloat)width count:(NSInteger)count space:(CGFloat)space edgeInsets:(UIEdgeInsets)insets;

+ (instancetype)cg_createWithWidth:(CGFloat)width count:(NSInteger)count InteritemSpace:(CGFloat)InteritemSpace lineSpace:(CGFloat)lineSpace edgeInsets:(UIEdgeInsets)insets;
@end
NS_ASSUME_NONNULL_END