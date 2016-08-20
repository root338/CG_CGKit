//
//  CGUpdateSubviewsFlowLayoutConfigModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/8/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseSubviewsFlowLayoutConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CGAddSubviewsCacheModel;

/** 为视图添加流类型的子视图时的更新布局设置 */
@interface CGUpdateSubviewsFlowLayoutConfigModel : CGBaseSubviewsFlowLayoutConfigModel

/** 
 *  从哪个索引开始更新
 *  @param 需要视图的索引不能重复，且是连续的
 *  @param 可以设置 CGCreateSubviewsFlowLayoutConfigModel 类的 isAutoSetupIndex 属性为YES，前提是被添加的视图没有添加任何其他视图
 */
@property (nonatomic, assign) NSInteger startFromIndexUpdate;

/** 视图设置布局的配置信息 */
@property (nullable, nonatomic, strong) NSArray<CGAddSubviewsCacheModel *> * subviewsLayoutConfigArray;
@end

NS_ASSUME_NONNULL_END