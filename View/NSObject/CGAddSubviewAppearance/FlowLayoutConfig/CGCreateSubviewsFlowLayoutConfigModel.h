//
//  CGCreateSubviewsFlowLayoutConfigModel.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseSubviewsFlowLayoutConfigModel.h"

/** 为视图创建流类型的子视图时的设置 */
@interface CGCreateSubviewsFlowLayoutConfigModel : CGBaseSubviewsFlowLayoutConfigModel

/** 自动设置标签 从0开始， 默认YES */
@property (nonatomic, assign) BOOL isAutoSetupIndex;

/** 使用创建的视图大小 */
@property (nonatomic, assign) BOOL isUseCreateViewSize;

@end
