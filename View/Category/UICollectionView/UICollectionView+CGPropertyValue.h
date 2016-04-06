//
//  UICollectionView+CGPropertyValue.h
//  TestCG_CGKit
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (CGPropertyValue)

/** 
 *  获取当前滑动序列值，从1开始
 *  @param scale无效
 *  @warning 仅在水平滑动时有效
 */
- (NSInteger)cg_calculateScrollPageWithScale:(CGFloat)scale;

@end
