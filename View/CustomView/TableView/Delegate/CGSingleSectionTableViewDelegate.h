//
//  CGSingleSectionTableViewDelegate.h
//  QuickAskCommunity
//
//  Created by DY on 15/8/10.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIkit.h>

@interface CGSingleSectionTableViewDelegate : NSObject<UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (assign, nonatomic) BOOL isEditCell;
@end
