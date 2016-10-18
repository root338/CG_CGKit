//
//  CGTitleListViewTableViewCell.h
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTableViewCell.h"

@class CGTitleListViewAppearance;
/** CGTitleListView 下的 cell */
@interface CGTitleListViewTableViewCell : CGTableViewCell


- (void)setupCellAppearance:(CGTitleListViewAppearance *)appearance;

@end
