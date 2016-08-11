//
//  CGSingleScrollView.h
//  PDPracticeDemo
//
//  Created by 345 on 15/5/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class CGSingleScrollView;
//@class CGRadioBaseView;
@class CGSingleSliderView, CGRadioTitleCellAppearance;

@protocol CGRadioViewDelegate;
@protocol CGSingleViewDataSource;


/*
----------------
    一些说明:
 
        获取选中按钮的回调可以实现 singleView属性的 delegate 属性协议，它是 CGRadioViewDelegate 协议属性
----------------
*/

/**
 *  横向滑动选择视图
 *  功能： 可以横向滑动视图，当是选择视图时可以执行单选
 *
 *  @warning 1.指定刷新索引没有完成。 2.删除功能需要添加 3.执行过程中得动画效果
 */
@interface CGSingleScrollView : UIView

/**
 单选视图
 */
//@property (readonly, nonatomic) CGRadioBaseView *singleView;

@property (nonatomic) id<CGRadioViewDelegate> delegate;

@property (nonatomic) id<CGSingleViewDataSource> dataSource;

/**
 选择的宽度
 */
@property (assign, nonatomic) CGFloat itemWidth;

/**
 视图之间的间距
 */
@property (assign, nonatomic) CGFloat itemSpace;

/** 设置标题的外观 */
@property (nonatomic, strong) CGRadioTitleCellAppearance *titleAppearance;

/**
 是否隐藏滑块 默认为NO
 */
@property (assign, nonatomic) BOOL hiddenSliderView;

@property (nonatomic, strong, readonly) CGSingleSliderView *sliderView;
@end
