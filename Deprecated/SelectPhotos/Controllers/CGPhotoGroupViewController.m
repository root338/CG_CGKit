//
//  CGPhotoGroupViewController.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoGroupViewController.h"
#import "CGPhotoNavigationController.h"
#import "CGPhotoListViewController.h"

#import "CGTableView.h"
#import "CGPhotoGroupTableViewCell.h"

#import "UIView+CGAddConstraints.h"

#import "CGAssetsLibraryManager.h"
#import "CGTableViewDataSourceManager.h"

@interface CGPhotoGroupViewController ()<UITableViewDelegate>

@property (nonatomic, strong) CGTableView *tableView;
@property (nonatomic, strong) CGTableViewDataSourceManager *dataSourceManager;

@property (readonly) CGAssetsLibraryManager *assetsLibraryManager;
@end

@implementation CGPhotoGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupPhotoGroupListView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.tableView.indexPathForSelectedRow) {
        [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPhotoGroupListView
{
    _tableView  = [[CGTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.isHideOverLineForPlainStyle  = YES;
    [self.view addSubview:_tableView];
    [_tableView cg_autoEdgesInsetsZeroToSuperview];
    
    Class registerCellClass = [CGPhotoGroupTableViewCell class];
    [_tableView cg_registerClassWithClassIdentifier:registerCellClass];
    self.dataSourceManager  = [[CGTableViewDataSourceManager alloc] initWithDataSource:self.assetsGroups cellIdentifierForClass:registerCellClass setupCellBlock:^(UITableView * _Nonnull tableView, __kindof CGTableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        [cell setupTableViewCellContentWithData:data];
    }];
    _tableView.dataSource   = self.dataSourceManager;
    _tableView.delegate     = self;
}

- (void)cg_setupPhotoGroupList:(NSArray *)photoGroupList
{
    self.dataSourceManager.dataSource   = photoGroupList;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGPhotoListViewController *photoListVC  = [CGPhotoListViewController cg_createPhotoList];
    photoListVC.assetsGroup = self.assetsGroups[indexPath.row];
    [self.navigationController pushViewController:photoListVC animated:YES];
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

- (CGAssetsLibraryManager *)assetsLibraryManager
{
    if ([self.navigationController isKindOfClass:[CGPhotoNavigationController class]]) {
        CGPhotoNavigationController *photoNavigationController  = (id)self.navigationController;
        return photoNavigationController.assetsLibraryManager;
    }
    return nil;
}

- (void)setAssetsGroups:(NSArray<ALAssetsGroup *> *)assetsGroups
{
    _assetsGroups   = assetsGroups;
    [self cg_setupPhotoGroupList:assetsGroups];
}

@end
