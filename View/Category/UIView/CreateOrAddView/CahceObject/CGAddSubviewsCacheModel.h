//
//  CGAddSubviewsCacheModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN
/** 添加子视图的缓存对象 */
@interface CGAddSubviewsCacheModel : CGBaseObject

//行数
@property (nonatomic, assign) NSInteger line;
@property (nonatomic, assign) NSInteger startViewTag;
@property (nonatomic, assign) NSInteger endViewTag;
//该行下的子视图集合
@property (nullable, nonatomic, strong) NSArray<UIView *> * subviews;
//该行下最大的子视图高度
@property (nonatomic, assign) CGFloat maxSubviewHeight;
//该行下最大的子视图宽度
@property (nonatomic, assign) CGFloat maxSubviewWidth;
//最后一个视图的坐标
@property (nonatomic, assign) CGPoint lastOrigin;

- (instancetype)initWithLastOrigin:(CGPoint)lastOrigin;

- (void)addView:(UIView *)view;
- (nullable UIView *)removeView:(UIView *)view;
/** 删除subviews索引下的视图 */
- (nullable UIView *)removeViewAtIndex:(NSInteger)index;
/** 删除指定视图 tag 属性的视图 */
- (nullable UIView *)removeViewAtViewTag:(NSInteger)viewTag;
@end

NS_ASSUME_NONNULL_END