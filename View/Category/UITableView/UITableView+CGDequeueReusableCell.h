//
//  UITableView+CGDequeueReusableCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UITableView (CGDequeueReusableCell)

- (nullable __kindof UITableViewCell *)cg_dequeueReusableCellWithClass:(nullable Class)identifier;

- (nullable __kindof UITableViewHeaderFooterView *)cg_dequeueReusableHeaderFooterWithClass:(nullable Class)identifier;
@end
NS_ASSUME_NONNULL_END