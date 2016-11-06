//
//  UIView+CGUpdateViewLayout.m
//  QuickAskCommunity
//
//  Created by DY on 16/9/30.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIView+CGUpdateViewLayout.h"

@implementation UIView (CGUpdateViewLayout)

- (void)cg_updateConstraintsIfNeeded
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)cg_layoutIfNeeded
{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)cg_viewUpdateContentLayoutIfNeeded
{
    [self cg_updateConstraintsIfNeeded];
    [self cg_layoutIfNeeded];
}

@end

@implementation UITableViewCell (CGUpdateCellLayout)

- (void)cg_updateContentLayoutIfNeeded
{
    [self.contentView cg_viewUpdateContentLayoutIfNeeded];
}

@end

@implementation UICollectionViewCell (CGUpdateCellLayout)

- (void)cg_updateContentLayoutIfNeeded
{
    [self.contentView cg_viewUpdateContentLayoutIfNeeded];
}

@end
