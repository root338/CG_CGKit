//
//  UITableView+CGDequeueReusableCell.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "UITableView+CGDequeueReusableCell.h"

@implementation UITableView (CGDequeueReusableCell)

- (nullable __kindof UITableViewCell *)cg_dequeueReusableCellWithClass:(nullable Class)identifier
{
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(identifier)];
}

- (nullable __kindof UITableViewHeaderFooterView *)cg_dequeueReusableHeaderFooterWithClass:(nullable Class)identifier
{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(identifier)];
}
@end
