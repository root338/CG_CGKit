//
//  CGTitlesTableView.h
//  TestCG_CGKit
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGTitlesTableView, CGRadioViewAppearance;

/** 标题视图的类型 */
typedef NS_ENUM(NSInteger, CGTitlesViewType) {
    /** 视图的页眉视图 */
    CGTitlesViewTypeViewHeader,
    /** TableView 的页眉视图 */
//    CGTitlesViewTypeTableViewHeader,
    /** TableView 的每组页眉视图 */
//    CGTitlesViewTypeTableViewSectionHeader,
};

@protocol CGTitlesTableViewDelegate <NSObject>

@required
/** 设置标题视图的样式 */
- (CGRadioViewAppearance *)titlesViewAppearanceForTitlesTableView:(CGTitlesTableView *)titlesTableView titlesViewType:(CGTitlesViewType)titlesViewType;
/** 设置表格列表的样式 */
- (CGRadioViewAppearance *)titlesTableView:(CGTitlesTableView *)titlesTableView tableViewAppearanceForIndex:(NSUInteger)index;

@optional

- (NSString *)titlesTableView:(CGTitlesTableView *)titlesTableView titleWithIndex:(NSUInteger)index;

@end

/** 多标题下tableView间的切换 */
@interface CGTitlesTableView : CGBaseView

@property (nonatomic, assign, readonly) CGTitlesViewType titlesViewType;

@property (nullable, nonatomic, weak) id<CGTitlesTableViewDelegate> delegate;

/** 当前选择的标题索引 */
@property (nonatomic, assign) NSUInteger currentIndex;

//标题列表
@property (nullable, nonatomic, strong) NSArray *titlesArray;

- (instancetype)initWithFrame:(CGRect)frame titlesViewType:(CGTitlesViewType)titlesViewType NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
