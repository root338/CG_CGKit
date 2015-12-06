//
//  UITableView+CGIndexPath.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "UITableView+CGIndexPath.h"
#import "UITableView+FirstLastCell.h"

typedef NS_ENUM(NSInteger, CGTableViewOfIndexPathType) {

    CGTableViewOfIndexPathTypePrevious = -1,
    CGTableViewOfIndexPathTypeNext = 1,
};

@implementation UITableView (CGIndexPath)

- (NSIndexPath *)cg_previousIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    return [self cg_indexPathWithType:CGTableViewOfIndexPathTypePrevious currentIndexPath:currentIndexPath];
}

- (NSIndexPath *)cg_nextIndexPathWithCurrentIndexPath:(NSIndexPath *)currentIndexPath
{
    return [self cg_indexPathWithType:CGTableViewOfIndexPathTypeNext currentIndexPath:currentIndexPath];
}

- (NSIndexPath *)cg_indexPathWithType:(CGTableViewOfIndexPathType)type currentIndexPath:(NSIndexPath *)currentIndexPath
{
    NSInteger section           = currentIndexPath.section;
    NSInteger row               = currentIndexPath.row;
    NSIndexPath *newIndexPath   = nil;
    
    if ([self cg_tableViewWithSection:section isExistRow:row + type]) {
        
        newIndexPath =  [self cg_IndexPathForSection:section row:row + type];
    }else if ([self cg_tableViewIsExistSection:section + type]) {
        
        NSInteger newSection = section + type;
        if (type == CGTableViewOfIndexPathTypePrevious) {
            newIndexPath = [self cg_lastIndexPathForSection:newSection];
        }else {
            newIndexPath = [self cg_firstIndexPathForSection:newSection];
        }
    }
    
    return newIndexPath;
}

@end
