//
//  CGBaseTableViewDataSourceManager+CGSetupSectionNumber.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseTableViewDataSourceManager+CGSetupSectionNumber.h"
#import <objc/runtime.h>

@implementation CGBaseTableViewDataSourceManager (CGSetupSectionNumber)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionNumber ? self.sectionNumber : 1;
}

#pragma mark - 设置属性
- (void)setSectionNumber:(NSInteger)numberOfSections
{
    
    objc_setAssociatedObject(self, @selector(sectionNumber), @(numberOfSections), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)sectionNumber
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

@end
