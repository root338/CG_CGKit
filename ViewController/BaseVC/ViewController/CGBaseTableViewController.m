//
//  CGBaseTableViewController.m
//  QuickAskCommunity
//
//  Created by DY on 15/10/10.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGBaseTableViewController.h"

@interface CGBaseTableViewController ()

@property (nonatomic, strong, readwrite) CGTableView *tableView;

@end

@implementation CGBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 设置属性
- (CGTableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[CGTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    
    return _tableView;
}

@end
