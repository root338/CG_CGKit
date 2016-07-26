////
////  CGCycleScrollView+CGBuildView.h
////  TestProject
////
////  Created by DY on 15/11/25.
////  Copyright © 2015年 -. All rights reserved.
////
//
//#import "CGCycleScrollView.h"
//#import "CGCycleViewPrivateHeader.h"
//
/////构建视图
//@interface CGCycleScrollView (CGBuildView)
//
///** 
// *  获取相应索引，默认使用currentIndex索引，会自动改变当前索引值
// *  @warning 不可用时返回nil，注意使用时需要判断是否为空，否则使用隐式转换时会变为0，而出错
// */
//- (NSNumber *)getViewIndexForType:(_CGCycleSubviewType)subviewType;
//
///**
// *  获取当前指定索引下的相应索引，不会自动改变指定索引值
// *  @warning 不可用时返回nil，注意使用时需要判断是否为空，否则使用隐式转换时会变为0，而出错
// */
//- (NSNumber *)getViewIndexWithCurrentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)subviewType;
//
///** 
// *  获取当前指定索引下的相应索引
// *  @warning 不可用时返回nil，注意使用时需要判断是否为空，否则使用隐式转换时会变为0，而出错
// */
//- (NSNumber *)getViewIndexWithCurrentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)subviewType isAutoChangeCurrentIndex:(BOOL)isAutoChange;
//
///**
// *  获取当前指定索引下的相应索引，是否自动改变当前索引
// *
// *  @param paramCurrentIndex 设置的当前索引
// *  @param subviewType       获取的页类型
// *  @param isAutoChange      是否自动修改当前索引
// *  @param completion        结果返回
// *
// */
//- (void)getViewIndexWithCurrentIndex:(NSInteger)paramCurrentIndex type:(_CGCycleSubviewType)subviewType autoChangeCurrentIndex:(BOOL)isAutoChange completion:(void(^)(BOOL isSuccess, NSInteger changedCurrentIndex, NSInteger viewIndex))completion;
//@end
