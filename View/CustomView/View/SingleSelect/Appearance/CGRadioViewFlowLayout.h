//
//  CGRadioViewFlowLayout.h
//  TestCG_CGKit
//
//  Created by apple on 16/11/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

@interface CGRadioViewFlowLayout : CGBaseObject

//滑动视图的设置
@property (nonatomic, assign, readonly)           UIEdgeInsets        marginEdgeInsets;
/** 滑动视图滑动的方向, 默认 UICollectionViewScrollDirectionHorizontal */
@property (nonatomic, assign, readonly)           UICollectionViewScrollDirection scrollDirection;

//内部选择按钮设置
/** 自动计算选择按钮,默认为YES */
@property (nonatomic, assign, readonly)           BOOL                isAutoItemSize;
@property (nonatomic, assign, readonly)           CGSize              itemSize;
/** item 的宽度等于父视图的宽度，默认NO */
@property (nonatomic, assign, readonly)           BOOL itemWidthEqualSuperViewWidth;
/** item 的高度等于父视图的高度，默认NO */
@property (nonatomic, assign, readonly)           BOOL itemHeightWidthEqualSuperViewHeight;

/** 选择按钮之间的间距 */
@property (nonatomic, assign, readonly)           CGFloat             minimumInteritemSpacing;
@property (nonatomic, assign, readonly)           CGFloat             minimumLineSpacing;

@end

@interface CGMutableRadioViewFlowLayout : CGRadioViewFlowLayout

@property (nonatomic)           UIEdgeInsets        marginEdgeInsets;
@property (nonatomic)           UICollectionViewScrollDirection scrollDirection;
@property (nonatomic)           BOOL                isAutoItemSize;
@property (nonatomic)           CGSize              itemSize;
@property (nonatomic)           BOOL itemWidthEqualSuperViewWidth;
@property (nonatomic)           BOOL itemHeightWidthEqualSuperViewHeight;
@property (nonatomic)           CGFloat             minimumInteritemSpacing;
@property (nonatomic)           CGFloat             minimumLineSpacing;


@end
