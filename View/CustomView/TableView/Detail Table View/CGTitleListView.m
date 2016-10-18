//
//  CGTitleListView.m
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleListView.h"
#import "CGTableView.h"
#import "CGTitleListViewTableViewCell.h"

#import "CGTableReuseHeader.h"
#import "UIView+CGAddConstraints.h"

#import "CGTitleListViewAppearance.h"

@interface CGTitleListView ()<UITableViewDataSource>
{
    
}

@property (nonatomic, copy) setupTitleForTableViewCellBlock setupTitleBlock;
@property (nonatomic, copy) setupTitleImageForTableViewCellBlock setupTitleImageBlock;

@property (nullable, nonatomic, strong, readwrite) CGTableView *tableView;

@property (nonatomic, strong, readwrite) CGTitleListViewAppearance *appearance;
@end

@implementation CGTitleListView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame appearance:[CGTitleListViewAppearance defaultTitleListViewAppearance]];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame appearance:(CGTitleListViewAppearance *)appearance
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContentViewWithFrame:frame appearance:appearance];
    }
    return self;
}

- (void)setupContentViewWithFrame:(CGRect)frame appearance:(CGTitleListViewAppearance *)appearance
{
    _appearance = appearance;
    _tableView  = [[CGTableView alloc] initWithFrame:frame style:appearance.tableViewStyle];
    [self addSubview:_tableView];
    [_tableView cg_registerClassWithClassIdentifier:[CGTitleListViewTableViewCell class]];
    
    [_tableView cg_autoEdgesInsetsZeroToSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupDataSource:(NSArray *)dataSource getTitleBlock:(nonnull setupTitleForTableViewCellBlock)titleBlock
{
    self.dataSource         = dataSource;
    self.setupTitleBlock    = titleBlock;
}

- (void)setupDataSource:(NSArray *)dataSource getTitleImageModelBlock:(setupTitleImageForTableViewCellBlock)titleImageBlock
{
    self.dataSource             = dataSource;
    self.setupTitleImageBlock   = titleImageBlock;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGTitleListViewTableViewCell *cell  = [tableView cg_dequeueReusableCellWithClass:[CGTitleListViewTableViewCell class]];
    [cell setupCellAppearance:self.appearance];
    [cell setupTableViewCellContentWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - 设置属性
- (CGTitleListViewAppearance *)appearance
{
    if (_appearance) {
        return _appearance;
    }
    
    _appearance = [CGTitleListViewAppearance defaultTitleListViewAppearance];
    return _appearance;
}
@end
