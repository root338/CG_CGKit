//
//  UIView+DeleteTableView.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DeleteTableView)<UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource_loadData;

@end
