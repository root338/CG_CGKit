//
//  UIView+CustomTableHeaderView.m
//  QuickAskCommunity
//
//  Created by DY on 15/8/11.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UIView+CustomTableHeaderView.h"
#import <objc/runtime.h>

@implementation UIView (CustomTableHeaderView)

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (self.setupTableViewHeader) {
        height = [self.setupTableViewHeader(YES, tableView, section) floatValue];
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    if (self.setupTableViewHeader) {
        headerView = self.setupTableViewHeader(NO, tableView, section);
    }
    
    return headerView;
}

#pragma mark - 设置属性
- (void)setSetupTableViewHeader:(SetupSectionViewProperty)paramSetupTableViewHeader
{
    objc_setAssociatedObject(self, @selector(setupTableViewHeader), paramSetupTableViewHeader, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (SetupSectionViewProperty)setupTableViewHeader
{
    return objc_getAssociatedObject(self, @selector(setupTableViewHeader));
}
@end
