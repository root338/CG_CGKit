//
//  CGSingleViewDataSource.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/14.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CGRadioView;

@protocol CGSingleViewDataSource <NSObject>

/**
 *  当前组需要显示多少个选择按钮
 *
 *  @param singleView 单选视图
 *
 *  @return 返回每组行数
 */
- (NSInteger)singleView:(CGRadioView *)singleView numberOfRowsInSection:(NSInteger)section;

@optional

///**
// *  创建的组数
// *
// *  @param singleView 单选视图
// *
// *  @return 返回组数
// */
//- (NSInteger)singleView:(CGRadioView *)singleView numberOfSections:(NSInteger)index;

/**
 *  创建单选视图需要加载的按钮
 *
 *
 *  @param singleView 单选视图
 *  @param index      所要加载视图的索引
 *
 *  @return 返回设置的按钮
 */
- (UIView *)singleView:(CGRadioView *)singleView controlAtIndex:(NSIndexPath *)indexPath;

/**
 *  创建单选视图需要加载的标题
 *  @warning singleView:controlAtIndex:方法会覆盖此方法
 *
 *  @param singleView 单选视图
 *  @param indexPath  所要加载标题的索引
 *
 *  @return 返回所要设置的标题
 */
- (NSString *)singleView:(CGRadioView *)singleView controlTitleAtIndex:(NSIndexPath *)indexPath;

/**
 设置视图的宽度
 */
- (CGFloat)singleView:(CGRadioView *)tabScrollView widthForIndexPath:(NSIndexPath *)indexPath;

///因为间距是两个视图之间在有的，所以还不知道单个设置两个视图的间距时 这个方法返回的值作用的是左边还是右边
///**
// *  设置视图之间的间距
// *
// *  @param tabScrollView 滑动视图
// *  @param index 所设置的控件索引
// *
// *  @return 返回设置的索引
// */
//- (CGFloat)singleView:(CGSingleScrollView *)singleView spaceForIndex:(NSInteger)index;
@end
