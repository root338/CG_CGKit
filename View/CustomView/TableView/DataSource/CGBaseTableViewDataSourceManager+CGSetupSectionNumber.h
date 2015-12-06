//
//  CGBaseTableViewDataSourceManager+CGSetupSectionNumber.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseTableViewDataSourceManager.h"

/** 手动设置tableView 多少组 */
//typedef NSUInteger (^CGNumberOfSectionsInTableView) (UITableView *tableView);

/** 实现设置tableView组数的扩展 */
@interface CGBaseTableViewDataSourceManager (CGSetupSectionNumber)

/** tableView有多少组 */
@property (assign, nonatomic) NSInteger sectionNumber;

@end
