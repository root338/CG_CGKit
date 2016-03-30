//
//  CGSingeContentTableView.h
//  TestCG_CGKit
//
//  Created by apple on 16/3/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGBaseView.h"

NS_ASSUME_NONNULL_BEGIN
@interface CGSingeContentTableView : CGBaseView

@property (nonatomic, strong, readonly) UITableView *tableView;

- (instancetype)initWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)style;
@end
NS_ASSUME_NONNULL_END