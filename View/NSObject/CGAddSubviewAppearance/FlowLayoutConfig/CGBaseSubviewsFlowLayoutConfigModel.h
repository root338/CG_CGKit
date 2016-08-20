//
//  CGBaseSubviewsFlowLayoutConfigModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"
#import "CGAlignmentHeader.h"

/** 为视图添加流类型的子视图时的基本布局设置 */
@interface CGBaseSubviewsFlowLayoutConfigModel : CGBaseObject

/** 子视图的加载方式 默认CGAlignmentTypeVertical */
@property (nonatomic, assign) CGAlignmentType alignmentType;
/** 每行子视图之间的垂直对齐方式 */
@property (nonatomic, assign) CGViewVerticalAlignment subviewsVerticalAlignment;

/** 需要添加的子视图总数 */
@property (nonatomic, assign) NSInteger totalCount;

/** 行间距 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 项目间距 */
@property (nonatomic, assign) CGFloat interitemSpacing;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;

/** 子视图的大小 */
@property (nonatomic, assign) CGSize itemSize;

/** 内容视图的最大宽度，该宽度为需要加上 marginEdgeInsets.left, marginEdgeInsets.right  */
@property (nonatomic, assign) CGFloat contentMaxWidth;
@end
