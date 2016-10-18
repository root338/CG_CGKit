//
//  CGTitleListViewAppearance.m
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleListViewAppearance.h"

@interface CGTitleListViewAppearance ()

@property (nonatomic, assign, readwrite) UITableViewStyle tableViewStyle;


#pragma mark - Cell 的全局设置
@property (nonatomic, assign, readwrite) CGFloat cellHeight;
/** 是否打开 cell 的高度缓存 */
@property (nonatomic, assign, readwrite) BOOL enableCellHeightCache;
/** cell 高度的类型 */
@property (nonatomic, assign, readwrite) CGTitleListCellHeightType cellHeigthType;

#pragma mark - Cell 的内容设置

@property (nullable, nonatomic, strong, readwrite) UIFont    * titleFont;
@property (nullable, nonatomic, strong, readwrite) UIColor   * titleColor;

/** 标题的行数，默认 1 */
@property (nonatomic, assign, readwrite) NSUInteger titleLabelLineNumber;

@property (nullable, nonatomic, strong, readwrite) UIColor   * cellBackgroundColor;

@end

@implementation CGTitleListViewAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tableViewStyle = UITableViewStylePlain;
        
        _cellHeight     = 44;
        _enableCellHeightCache  = NO;
        _cellHeigthType         = CGTitleListCellHeightTypeAdaptive;
        
        _titleLabelLineNumber   = 1;
        
    }
    return self;
}

+ (instancetype)defaultTitleListViewAppearance
{
    CGTitleListViewAppearance *appearance   = [self new];
    return appearance;
}
@end

@implementation CGMutableTitleListViewAppearance

@dynamic tableViewStyle;
@dynamic cellHeight;
@dynamic cellHeigthType;
@dynamic enableCellHeightCache;

@dynamic titleFont;
@dynamic titleColor;
@dynamic titleLabelLineNumber;
@dynamic cellBackgroundColor;

@end
