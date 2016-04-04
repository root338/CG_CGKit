//
//  CGPhotoGroupTableViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoGroupTableViewCell.h"

#import "ALAssetsGroup+CGProperty.h"

@implementation CGPhotoGroupTableViewCell

- (void)setupTableViewCellContentWithData:(id)paramData
{
    if ([paramData isKindOfClass:[ALAssetsGroup class]]) {
        
        ALAssetsGroup *assetsGroup  = paramData;
        self.imageView.image        = assetsGroup.posterAssetsGroupImage;
        self.textLabel.text         = assetsGroup.assetsGroupName;
    }
}

- (void)initialization
{
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
}
@end
