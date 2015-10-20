//
//  UITableView+FirstOrLastCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/10/19.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (FirstLastCell)

/** 是否是第一个或最后一个cell */
- (BOOL)isFirstLastCellWith:(NSIndexPath *)indexPath;

/** 是否是第一个cell */
- (BOOL)isFirstCellWith:(NSIndexPath *)indexPath;

/** 是否是最后一个cell */
- (BOOL)isLastCellWith:(NSIndexPath *)indexPath;
@end
