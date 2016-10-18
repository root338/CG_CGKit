//
//  CGTitleListView.h
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class CGTableView, CGTitleListViewAppearance, CGTitleImageListModel;

typedef NSString * _Nonnull (^setupTitleForTableViewCellBlock) (CGTableView *tableView, NSIndexPath *indexPath, id obj);
typedef UIImage * _Nonnull (^setupImageForTableViewCellBlock) (CGTableView *tableView, NSIndexPath *indexPath, id obj);
typedef CGTitleImageListModel * _Nonnull (^setupTitleImageForTableViewCellBlock) (CGTableView *tableView, NSIndexPath *indexPath, id obj);

/** 纯文本的标题列表，可以添加单张图片 */
@interface CGTitleListView : CGBaseView

@property (nullable, nonatomic, strong, readonly) CGTableView *tableView;

/** 表格源数据, 
 *  @param 默认支持 NSString, CGTitleImageListModel 对象, 当实现setupDataSource:getTitleBlock:或setupDataSource:getTitleImageModelBlock:时，由自定义block来解析数组中的对象 */
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong, readonly) CGTitleListViewAppearance *appearance;

- (void)setupDataSource:(nullable NSArray *)dataSource getTitleBlock:(setupTitleForTableViewCellBlock)titleBlock;
- (void)setupDataSource:(nullable NSArray *)dataSource getTitleImageModelBlock:(setupTitleImageForTableViewCellBlock)titleImageBlock;

- (instancetype)initWithFrame:(CGRect)frame appearance:(CGTitleListViewAppearance *)appearance NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
