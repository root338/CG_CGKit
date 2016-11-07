//
//  CGRadioViewFlowLayout.m
//  TestCG_CGKit
//
//  Created by apple on 16/11/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGRadioViewFlowLayout.h"

@interface CGRadioViewFlowLayout ()

//滑动视图的设置
@property (nonatomic, assign, readwrite)           UIEdgeInsets        marginEdgeInsets;
/** 滑动视图滑动的方向, 默认 UICollectionViewScrollDirectionHorizontal */
@property (nonatomic, assign, readwrite)           UICollectionViewScrollDirection scrollDirection;

//内部选择按钮设置
/** 自动计算选择按钮,默认为YES */
@property (nonatomic, assign, readwrite)           BOOL                isAutoItemSize;
@property (nonatomic, assign, readwrite)           CGSize              itemSize;

/** 选择按钮之间的间距 */
@property (nonatomic, assign, readwrite)           CGFloat             minimumInteritemSpacing;
@property (nonatomic, assign, readwrite)           CGFloat             minimumLineSpacing;
/** item 的宽度等于父视图的宽度，默认NO */
@property (nonatomic, assign, readwrite)           BOOL itemWidthEqualSuperViewWidth;
/** item 的高度等于父视图的高度，默认NO */
@property (nonatomic, assign, readwrite)           BOOL itemHeightWidthEqualSuperViewHeight;

@end

@implementation CGRadioViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _scrollDirection    = UICollectionViewScrollDirectionHorizontal;
        _marginEdgeInsets   = UIEdgeInsetsZero;
        _isAutoItemSize     = YES;
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    CGRadioViewFlowLayout *flowLayout   = [[[self class] alloc] init];
    [self copyWithAppearance:flowLayout];
    return flowLayout;
}

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(NSZone *)zone
{
    CGMutableRadioViewFlowLayout *flowLayout    = [[CGMutableRadioViewFlowLayout alloc] init];
    [self copyWithAppearance:flowLayout];
    return flowLayout;
}

- (void)copyWithAppearance:(CGRadioViewFlowLayout *)flowLayout
{
    flowLayout.marginEdgeInsets         = self.marginEdgeInsets;
    flowLayout.scrollDirection          = self.scrollDirection;
    flowLayout.isAutoItemSize           = self.isAutoItemSize;
    flowLayout.itemSize                 = self.itemSize;
    flowLayout.minimumInteritemSpacing  = self.minimumInteritemSpacing;
    flowLayout.minimumLineSpacing       = self.minimumLineSpacing;
    flowLayout.itemWidthEqualSuperViewWidth = self.itemWidthEqualSuperViewWidth;
    flowLayout.itemHeightWidthEqualSuperViewHeight  = self.itemHeightWidthEqualSuperViewHeight;
}

@end

@implementation CGMutableRadioViewFlowLayout

@dynamic marginEdgeInsets;
@dynamic scrollDirection;
@dynamic isAutoItemSize;
@dynamic itemSize;
@dynamic minimumInteritemSpacing;
@dynamic minimumLineSpacing;
@dynamic itemWidthEqualSuperViewWidth;
@dynamic itemHeightWidthEqualSuperViewHeight;

@end
