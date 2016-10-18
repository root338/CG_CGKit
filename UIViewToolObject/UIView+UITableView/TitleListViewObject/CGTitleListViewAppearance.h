//
//  CGTitleListViewAppearance.h
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/** cell高度的类型 */
typedef NS_ENUM(NSInteger, CGTitleListCellHeightType) {
    /** 自适应 */
    CGTitleListCellHeightTypeAdaptive,
    /** 固定高度 */
    CGTitleListCellHeightTypeFixedHeight,
    
};

/** CGTitleListView类下的外观设置 */
@interface CGTitleListViewAppearance : CGBaseObject

@property (nonatomic, assign, readonly) UITableViewStyle tableViewStyle;


#pragma mark - Cell 的全局设置
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 是否打开 cell 的高度缓存 */
@property (nonatomic, assign, readonly) BOOL enableCellHeightCache;
/** cell 高度的类型 */
@property (nonatomic, assign, readonly) CGTitleListCellHeightType cellHeigthType;


#pragma mark - Cell 的内容设置

@property (nullable, nonatomic, strong, readonly) UIFont    * titleFont;
@property (nullable, nonatomic, strong, readonly) UIColor   * titleColor;
/** 标题的行数，默认 1 */
@property (nonatomic, assign, readonly) NSUInteger titleLabelLineNumber;



@property (nullable, nonatomic, strong, readonly) UIColor   * cellBackgroundColor;

+ (instancetype)defaultTitleListViewAppearance;
@end

@interface CGMutableTitleListViewAppearance : CGTitleListViewAppearance

@property (nonatomic) UITableViewStyle tableViewStyle;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic) BOOL enableCellHeightCache;
@property (nonatomic) CGTitleListCellHeightType cellHeigthType;
@property (nullable, nonatomic) UIFont    * titleFont;
@property (nullable, nonatomic) UIColor   * titleColor;
@property (nonatomic) NSUInteger titleLabelLineNumber;
@property (nullable, nonatomic) UIColor   * cellBackgroundColor;

@end

NS_ASSUME_NONNULL_END
