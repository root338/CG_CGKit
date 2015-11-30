//
//  UITableView+CGChangeGroupStyle.h
//  TestProject
//
//  Created by DY on 15/11/30.
//  Copyright © 2015年 -. All rights reserved.
//

#import <UIKit/UIKit.h>

CG_EXTERN const CGFloat   _CG_TableView_ZeroHeight;
CG_EXTERN const CGRect    _CG_TableView_ZeroRect;

/**
 *  iOS 7
 *  当设置UITableView的样式为UITableViewStyleGrouped时表格的页眉、页脚，每组的页眉、页脚都会设置一定的间距
 *  若想将这些间距取消掉，就要手动设置这些间距无限接近于0，@warning 不能等于0
 *
 */
@interface UITableView (CGChangeGroupStyle)

/** 注意：这里方法写的Zero，并不是等于0，而是_CG_TableView_ZeroHeight */

/** 
 *  设置表格的页眉高度为_CG_TableView_ZeroHeight 
 *  @warning UITableView中没有全局设置tableViewHeaderView高度的属性，此方法会重新创建一个UIView，并赋值给tableViewHeaderView属性，所以如果之前已经有页眉请注意会被覆盖
 */
- (void)cg_tableViewChangeHeaderViewZeroHeight;

/**
 *  设置表格的页脚高度为_CG_TableView_ZeroHeight 
 *  @warning UITableView中没有全局设置tableViewFooterView高度的属性，此方法会重新创建一个UIView，并赋值给tableViewFooterView属性，所以如果之前已经有页脚请注意会被覆盖
 */
- (void)cg_tableViewChangeFooterViewZeroHeight;

/** 将UITableView页眉页脚高度设为Zero */
- (void)cg_tableViewChangeHeaderFooterZeroHeight;

/** 
 *  设置表格每组的页眉为_CG_TableView_ZeroHeight 
 *  @warning 该方法设置的是sectionHeaderHeight属性值，当实现tableView:viewForHeaderInSection:协议方法时需要自行设置
 */
- (void)cg_tableViewChangeSectionHeaderViewZeroHeight;

/** 
 *  设置表格每组的页脚为_CG_TableView_ZeroHeight 
 *  @warning 该方法设置的是sectionFooterHeight属性值，当实现tableView:viewForFooterInSection:协议方法时需要自行设置
 */
- (void)cg_tableViewChangeSectionFooterViewZeroHeight;
@end
