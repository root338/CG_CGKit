//
//  CGTitlesSourceDataModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/10/23.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseObject.h"



/** 每页加载数据的模型 */
@interface CGTitlesSinglePageModel : NSObject
/** 加载的页数 */
@property (nonatomic, assign) NSUInteger page;
/** 改页需要加载的数量 */
@property (nonatomic, assign) NSUInteger count;
/** 获取到的数据 */
@property (nullable, nonatomic, strong) NSArray *dataSource;

@end

/** CGTitlesTableView 对象的缓存数据模型 */
@interface CGTitlesSourceDataModel : CGBaseObject

#pragma mark - 加载数据记录
//加载的页数
@property (nonatomic, assign) NSUInteger currentPage;
//表格的数据内容
@property (nullable, nonatomic, copy) NSArray *dataSource;



#pragma mark - 视图内容记录
//表格偏移的坐标
@property (nonatomic, assign) CGPoint contentOffset;
//表格的屏幕快照
@property (nullable, nonatomic, strong) UIImage *snapshotImage;
//表格的cell缓存高度
@property (nullable, nonatomic, copy) NSDictionary<NSIndexPath *, NSNumber *> *cellHeights;

//标识
@property (nullable, nonatomic, strong) NSString *identifier;
@end
