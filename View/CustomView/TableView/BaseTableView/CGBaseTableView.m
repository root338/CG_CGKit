//
//  CGBaseTableView.m
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "CGBaseTableView.h"

#import "CGPrintLogHeader.h"

@implementation CGBaseTableView

//- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(CGSetupTableViewCell)setupCellBlock
//{
//    self = [super init];
//    if (self) {
//        [self.dataSourceManager setupDataSource:dataSource cellIdentifierForClass:cellIdentifier setupCellBlock:setupCellBlock];
//    }
//    return self;
//}
#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initialization];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
        
    }
    return self;
}

- (void)awakeFromNib
{
    
    [super awakeFromNib];
    [self initialization];
}

- (void)initialization
{
    
}

#pragma mark - 属性设置

@end
