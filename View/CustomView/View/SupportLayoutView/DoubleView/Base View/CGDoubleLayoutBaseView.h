//
//  CGDoubleLayoutBaseView.h
//  TestCG_CGKit
//
//  Created by apple on 16/7/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"
#import "CGAlignmentHeader.h"
#import "CGLayoutMarginDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/** 双数视图基类 */
@interface CGDoubleLayoutBaseView : CGBaseView<CGDoubleLayoutDelegate>

/** 两个视图之间的间距 */
@property (nonatomic, assign) CGFloat targetViewsBetweenSapce;

/** 两个视图之间的间距关系，默认 NSLayoutRelationEqual */
@property (nonatomic, assign) NSLayoutRelation  betweenSpaceRelation;
/** 外边距 */
@property (nonatomic, assign) UIEdgeInsets marginEdgeInsets;

//设置两个视图是否居中显示
//当水平对齐时，居中代表垂直居中
//当垂直对齐时，居中代表水平居中

@property (nonatomic, assign) BOOL firstViewCenter;
@property (nonatomic, assign) BOOL secondViewCenter;

/** 第一个视图的外边距 */
@property (nonatomic, assign) UIEdgeInsets firstTargetViewEdgeInsets;
/** 第二个视图的外边距 */
@property (nonatomic, assign) UIEdgeInsets secondTargetViewEdgeInsets;

/** 设置第一个视图的大小，大于0处理 */
@property (nonatomic, assign) CGSize firstItemSize;
/** 设置第二个视图的大小，大于0处理 */
@property (nonatomic, assign) CGSize secondItemSize;

/** 两个视图之间的对齐方式 */
@property (nonatomic, assign) CGAlignmentType alignment;

@property (nonatomic, strong, readonly) UIView *contentView;

/** 第一个视图 */
- (UIView *)cg_layoutFirstTargetView;
/** 第二个视图 */
- (UIView *)cg_layoutSecondTargetView;

@end

NS_ASSUME_NONNULL_END
