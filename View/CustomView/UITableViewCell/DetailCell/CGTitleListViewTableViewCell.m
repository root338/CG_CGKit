//
//  CGTitleListViewTableViewCell.m
//  QuickAskCommunity
//
//  Created by DY on 2016/10/18.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "CGTitleListViewTableViewCell.h"
#import "CGMultilineLabel.h"
#import "CGTitleImageLayoutView.h"

#import "CGTitleImageListModel.h"
#import "CGTitleListViewAppearance.h"

@interface CGTitleListViewTableViewCell ()
{
    BOOL didSetupCellAppearance;
    
    CGTitleImageLayoutView *_titleImageView;
}
@end

@implementation CGTitleListViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setupTableViewCellContentWithData:(id)paramData
{
    if ([paramData isKindOfClass:[NSString class]]) {
        _titleImageView.titleLabel.text = paramData;
    }else if ([paramData isKindOfClass:[CGTitleImageListModel class]]) {
        
        CGTitleImageListModel *model    = paramData;
        _titleImageView.titleLabel.text = model.title;
        _titleImageView.imageView.image = model.image;
    }
}

- (void)setupCellAppearance:(CGTitleListViewAppearance *)appearance
{
    if (!didSetupCellAppearance) {
        
        self.contentView.backgroundColor    = appearance.cellBackgroundColor;
        _titleImageView.titleLabel.numberOfLines    = appearance.titleLabelLineNumber;
        _titleImageView.titleLabel.font             = appearance.titleFont;
        _titleImageView.titleLabel.textColor        = appearance.titleColor;
        
        didSetupCellAppearance  = YES;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
