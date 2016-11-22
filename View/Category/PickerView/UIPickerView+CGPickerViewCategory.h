//
//  UIPickerView+CGPickerViewCategory.h
//  QuickAskCommunity
//
//  Created by DY on 2016/11/21.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 验证 */
@interface UIPickerView (CGVerify)

/** 指定的组是否可用 */
- (BOOL)availableWithComponent:(NSInteger)component;

/** 指定的组的行数是否可用 */
- (BOOL)availableWithRow:(NSInteger)row inComponent:(NSInteger)component;
@end

/** 选择 */
@interface UIPickerView (CGSelect)

/** 是否关闭选择动画 */
@property (nonatomic, assign) BOOL disableSelectAnimated;

/** 选择指定组数的行数，成功返回YES */
- (BOOL)cg_selectRow:(NSInteger)row inComponent:(NSInteger)component;
/** 选择指定组数的行数, 成功返回YES */
- (BOOL)cg_selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;

/** 刷新指定组，成功返回YES */
- (BOOL)cg_reloadComponent:(NSInteger)component;

/** 获取指定组选择行数 */
- (NSInteger)cg_selectedRowInComponent:(NSInteger)component;
@end
