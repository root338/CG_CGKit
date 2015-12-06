//
//  UITableView+CGIndexPath.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CGIndexPath)

/** 获取指定 indexPath 的上一个索引 */
- (NSIndexPath *)cg_previousIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath;

/** 获取指定 indexPath 的下一个索引 */
- (NSIndexPath *)cg_nextIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath;

@end
