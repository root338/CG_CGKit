//
//  UITableView+CreateTableView.m
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import "UITableView+CGCreateTableView.h"

@implementation UITableView (CGCreateTableView)

#pragma mark - 普通创建TableView
+ (instancetype)createTableViewStyle:(UITableViewStyle)style
{
    
    return [self createTableViewStyle:style rowHeight:0];
}

+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight
{
    UITableView *tableView = [[self alloc] initWithFrame:CGRectZero style:style];
    
    if (rowHeight != 0) {
        tableView.rowHeight = rowHeight;
    }
    
    return tableView;
}

#pragma mark - 类方式加载cell
+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight cellForClass:(Class)cellClass
{
    return [self createTableViewStyle:style rowHeight:rowHeight cellForClass:cellClass isXibLoad:NO];
}

#pragma mark - xib 加载cell
+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight nibCellName:(NSString *)nibCellName cellForClass:(Class)cellClass
{
    return [self createTableViewStyle:style rowHeight:rowHeight nibCellName:nibCellName cellForClass:cellClass isXibLoad:YES];
}

#pragma mark - 创建设置cell的TableView，并且可以自定义的指定加载cell的方式，xib加载或类加载
+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight cellForClass:(Class)cellClass isXibLoad:(BOOL)isXibLoad
{
    return [self createTableViewStyle:style rowHeight:rowHeight nibCellName:nil cellForClass:cellClass isXibLoad:isXibLoad];
}

+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight nibCellName:(NSString *)nibCellName cellForClass:(Class)cellClass isXibLoad:(BOOL)isXibLoad
{
    UITableView *tableView = [self createTableViewStyle:style rowHeight:rowHeight];
    
    if (isXibLoad) {
        if (!nibCellName) {
            //当xib加载时，nibCellName为空时，自动将cellClass名设置为nibCellName
            nibCellName = NSStringFromClass(cellClass);
        }
        if (nibCellName) {
            
            UINib *nib = [UINib nibWithNibName:nibCellName bundle:[NSBundle bundleForClass:cellClass]];
            [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass(cellClass)];
            
        }
    }else {
        
        [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
    
    return tableView;
}
@end
