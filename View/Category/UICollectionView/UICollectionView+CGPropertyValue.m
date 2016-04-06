//
//  UICollectionView+CGPropertyValue.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UICollectionView+CGPropertyValue.h"
#import "UIView+CGSetupFrame.h"

@implementation UICollectionView (CGPropertyValue)

- (NSInteger)cg_calculateScrollPageWithScale:(CGFloat)scale
{
    NSArray<UICollectionViewCell *> *visibleCells = [self visibleCells];
    CGPoint visibleCenter   = CGPointMake(self.contentOffset.x + self.width / 2, 0);
    
    __block UICollectionViewCell *targetCell    = nil;
    
    [visibleCells enumerateObjectsUsingBlock:^(UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (CGRectContainsPoint(obj.frame, visibleCenter)) {
//            targetCell  = obj;
//            *stop   = YES;
//        }
        if (!targetCell) {
            
            targetCell  = obj;
        }else {
            
            if (fabs(targetCell.center.x - visibleCenter.x) > fabs(obj.center.x - visibleCenter.x)) {
                targetCell  = obj;
            }
        }
    }];
    NSIndexPath *indexPath  = [self indexPathForCell:targetCell];
    return indexPath.row + 1;
}

@end
