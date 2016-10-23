//
//  CGBaseTableView.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGTableView.h"

#import "CGPrintLogHeader.h"

@implementation CGTableView

//- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(CGSetupTableViewCell)setupCellBlock
//{
//    self = [super init];
//    if (self) {
//        [self.dataSourceManager setupDataSource:dataSource cellIdentifierForClass:cellIdentifier setupCellBlock:setupCellBlock];
//    }
//    return self;
//}

#pragma mark - 属性设置

- (void)setIsHideOverLineForPlainStyle:(BOOL)isHideOverLineForPlainStyle
{
    if (_isHideOverLineForPlainStyle != isHideOverLineForPlainStyle) {
        
        _isHideOverLineForPlainStyle    = isHideOverLineForPlainStyle;
        if (isHideOverLineForPlainStyle) {
            
            if (!self.tableFooterView) {
                self.tableFooterView    = [[UIView alloc] initWithFrame:CGRectZero];
            }
        }else {
            
            self.tableFooterView    = nil;
        }
    }
}

@end
