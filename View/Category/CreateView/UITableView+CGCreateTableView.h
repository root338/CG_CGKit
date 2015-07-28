//
//  UITableView+CreateTableView.h
//  QuickAskCommunity
//
//  Created by DY on 15/7/24.
//  Copyright (c) 2015年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  快速创建TableView的扩展方法
 */
@interface UITableView (CGCreateTableView)

+ (instancetype)createTableViewStyle:(UITableViewStyle)style;

+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight;

/**
 *  @warning 类方式加载cell
 */
+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight cellForClass:(Class)cellClass;

+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight cellForClass:(Class)cellClass isXibLoad:(BOOL)isXibLoad;

+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight nibCellName:(NSString *)nibCellName cellForClass:(Class)cellClass;

/**
 *  创建TableView
 *
 *  @param style          TableView类型
 *  @param rowHeight      cell高度
 *  @param nibCellName    当cell为xib加载时，xib文件名
 *  @param cellClass      cell的类名，并且设为cell在TableView中的标识 @warning 当为xib加载时 且nibCellName为空时， cellClass类名会自动变为cell的xib文件名
 *  @param isXibLoad      加载cell的方式，YES： xib加载， NO：类加载
 *
 *  @return 返回创建好的TableView
 */
+ (instancetype)createTableViewStyle:(UITableViewStyle)style rowHeight:(CGFloat)rowHeight nibCellName:(NSString *)nibCellName cellForClass:(Class)cellClass isXibLoad:(BOOL)isXibLoad;
@end
