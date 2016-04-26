//
//  CGPhotoGroupTableViewCell.m
//  TestCG_CGKit
//
//  Created by apple on 16/4/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGPhotoGroupTableViewCell.h"

#import "UIFont+CGCreateFont.h"
#import "CGAssetsCollectionModel.h"

@interface CGPhotoGroupTableViewCell ()
{
    NSDictionary<NSString *, id> *_titleAttDictionary;
    NSDictionary<NSString *, id> *_numberAttDictionary;
}
@end

@implementation CGPhotoGroupTableViewCell

- (void)setupTableViewCellContentWithData:(id)paramData
{
    if ([paramData isKindOfClass:[CGAssetsCollectionModel class]]) {
        
        CGAssetsCollectionModel *assetsGroup    = paramData;
        [assetsGroup posterAssetsCollectionImage:^(UIImage * _Nonnull posterAssetImage) {
            self.imageView.image    = posterAssetImage;
        }];
        
        if (!_titleAttDictionary || !_numberAttDictionary) {
            
            [self setupTextAttributed];
        }
        
        NSMutableAttributedString *textAttributedString = [[NSMutableAttributedString alloc] initWithString:assetsGroup.assetsCollectionName attributes:_titleAttDictionary];
        NSString *number    = [NSString stringWithFormat:@" (%li)", (long)assetsGroup.numberOfAssets];
        [textAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:number attributes:_numberAttDictionary]];
        self.textLabel.attributedText   = textAttributedString;
    }else {
        NSAssert(nil, @"???");
    }
}

- (void)initialization
{
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setupTextAttributed
{
    UIFont *font            = [UIFont cg_defaultFontWithSize:14];
    UIColor *titleColor     = [UIColor blackColor];
    UIColor *numberColor    = [UIColor grayColor];
    _titleAttDictionary     = @{
                                NSFontAttributeName : font,
                                NSForegroundColorAttributeName : titleColor,
                                };
    _numberAttDictionary    = @{
                                NSFontAttributeName : font,
                                NSForegroundColorAttributeName : numberColor,
                                };
}
@end
