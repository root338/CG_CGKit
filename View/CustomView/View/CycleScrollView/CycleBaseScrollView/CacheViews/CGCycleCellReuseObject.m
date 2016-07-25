//
//  CGCycleCellReuseObject.m
//  TestCG_CGKit
//
//  Created by DY on 16/7/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGCycleCellReuseObject.h"

#import "CGCycleScrollViewCell.h"

@interface CGCycleCellReuseObject ()

@property (nonatomic, assign, readwrite) CGCycleCellReuseType cellReuseType;
@property (nullable, nonatomic, copy, readwrite) NSString *reuseIdentifier;

/** 正在使用的cell集合 */
@property (nonatomic, strong) NSMutableArray<CGCycleScrollViewCell *> *cellReuseForIsUsingArray;
/** 未使用的cell集合 */
@property (nonatomic, strong) NSMutableArray<CGCycleScrollViewCell *> *cellReuseForUnusedArray;
@end

@implementation CGCycleCellReuseObject

+ (instancetype)createCellReuseWithTargetObj:(id)targetObj identifier:(nonnull NSString *)identifier
{
    return [[self alloc] initWithTargetObj:targetObj identifier:identifier];
}

- (instancetype)initWithTargetObj:(id)targetObj identifier:(nonnull NSString *)identifier
{
    self    = [super init];
    if (self) {
        
        _reuseIdentifier    = identifier;
        if ([targetObj isKindOfClass:[UINib class]]) {
            _nib            = targetObj;
            _cellReuseType  = CGCycleCellReuseTypeNib;
        }else {
            _cellClass      = targetObj;
            _cellReuseType  = CGCycleCellReuseTypeClass;
        }
        
        _cellReuseForIsUsingArray   = [NSMutableArray array];
        _cellReuseForUnusedArray    = [NSMutableArray array];
    }
    return self;
}

- (__kindof CGCycleScrollViewCell *)cell
{
    CGCycleScrollViewCell *cell = [self getUnusedCell];
    
    if (!cell) {
        
        if (self.cellReuseType == CGCycleCellReuseTypeClass) {
            
            cell    = [[self.cellClass alloc] initWithReuseIdentifier:self.reuseIdentifier];
        }else if (self.cellReuseType == CGCycleCellReuseTypeNib) {
            
            cell    = [[self.nib instantiateWithOwner:nil options:nil] lastObject];
        }
        
        [self.cellReuseForIsUsingArray addObject:cell];
    }
    return cell;
}

/** 获取保存的未使用的cell */
- (nullable __kindof CGCycleScrollViewCell *)getUnusedCell
{
    CGCycleScrollViewCell *cell = [self.cellReuseForUnusedArray lastObject];
    if (cell) {
        [self.cellReuseForUnusedArray removeLastObject];
        [self.cellReuseForIsUsingArray addObject:cell];
    }
    
    return cell;
}

- (void)didRemoveViewCell:(CGCycleScrollViewCell *)cell
{
    [self.cellReuseForIsUsingArray removeObject:cell];
    [self.cellReuseForUnusedArray addObject:cell];
}

#pragma mark - 设置属性
- (void)setNib:(UINib *)nib
{
    _nib                = nib;
    self.cellReuseType  = CGCycleCellReuseTypeNib;
}

- (void)setCellClass:(Class)cellClass
{
    _cellClass          = cellClass;
    self.cellReuseType  = CGCycleCellReuseTypeClass;
}

@end
