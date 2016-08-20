//
//  CGSubviewsSizeAppearance.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGAlignmentHeader.h"

/**
 *  一个视图添加多个相同视图时的全局设置，通过设置子视图大小来设置布局
 *
 */
@interface CGSubviewsSizeAppearance : CGBaseObject

/** 子视图的加载方式 默认CGAlignmentTypeVertical */
@property (nonatomic, assign) CGAlignmentType alignmentType;

/** 需要添加的子视图总数 */
@property (nonatomic, assign) NSInteger totalCount;

/** 使用创建的视图大小 */
@property (nonatomic, assign) BOOL isUseCreateViewSize;

/** 子视图的大小 */
@property (nonatomic, assign) CGSize itemSize;

/** 行间距 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 项目间距 */
@property (nonatomic, assign) CGFloat interitemSpacing;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;
@end
