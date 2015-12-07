//
//  CGBaseTableView.h
//  TestCG_CGKit
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGViewProtocol.h"
#import "CGBaseTableViewDataSourceManager.h"
#import "UITableView+CGRegisterCell.h"

@interface CGBaseTableView : UITableView<CGViewInitializationProtocol>

@property (strong, nonatomic) CGBaseTableViewDataSourceManager *dataSourceManager;

//- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifierForClass:(Class)cellIdentifier setupCellBlock:(CGSetupTableViewCell)setupCellBlock;

@end
