//
//  UITableView+CGDequeueReusableCell.h
//  QuickAskCommunity
//
//  Created by DY on 15/9/24.
//  Copyright © 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CGDequeueReusableCell)

- (nullable __kindof UITableViewCell *)cg_dequeueReusableCellWithClass:(nullable Class)identifier;

@end
