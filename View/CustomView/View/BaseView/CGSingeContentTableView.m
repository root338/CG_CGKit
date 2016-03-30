//
//  CGSingeContentTableView.m
//  TestCG_CGKit
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGSingeContentTableView.h"

#import "CGTableViewDataSourceManager.h"

@interface CGSingeContentTableView ()

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation CGSingeContentTableView

- (instancetype)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTableViewWithStyle:style];
    }
    return self;
}

- (void)addTableViewWithStyle:(UITableViewStyle)style
{
    _tableView  = [[UITableView alloc] initWithFrame:self.bounds style:style];
    [self addSubview:_tableView];
}

#pragma mark - 设置属性

- (UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    [self addTableViewWithStyle:UITableViewStylePlain];
    return _tableView;
}

@end
