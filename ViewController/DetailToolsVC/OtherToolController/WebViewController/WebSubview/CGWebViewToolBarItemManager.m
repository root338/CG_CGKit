//
//  CGWebViewToolBarItemManager.m
//  TestCG_CGKit
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CGWebViewToolBarItemManager.h"


#import "CGCloseIconConfig.h"
#import "CGArrowIconConfig.h"

#import "UIImage+CGDrawIcon.h"
#import "UIImage+CGImageRotate.h"

@interface CGWebViewToolBarItemManager ()
{
    NSMutableDictionary<NSNumber *, UIImage *> *_itemImageCacheDict;
}

@end

@implementation CGWebViewToolBarItemManager

- (UIImage *)getImageWithItemType:(CGWebViewItemType)itemType
{
    NSNumber *key   = @(itemType);
    UIImage *image  = [_itemImageCacheDict objectForKey:key];
    
    if (image == nil) {
        
        if (_itemImageCacheDict == nil) {
            _itemImageCacheDict = [NSMutableDictionary dictionary];
        }
        
        switch (itemType) {
            case CGWebViewItemTypeBack:
            case CGWebViewItemTypeForward:
            {
                CGArrowIconConfig *config   = [CGArrowIconConfig new];
                config.size                 = CGSizeMake(20, 20);
                
                if (itemType == CGWebViewItemTypeForward) {
                    config.orientationType  = CGOrientationTypeRight;
                }else {
                    config.orientationType  = CGOrientationTypeLeft;
                }
                image   = [UIImage drawArrowWithConfig:config];
            }
                break;
            case CGWebViewItemTypeStopLoading:
            {
                CGCloseIconConfig *config   = [CGCloseIconConfig new];
                config.size                 = CGSizeMake(20, 20);
                image   = [UIImage drawCloseWithConfig:config];
            }
                break;
            default:
                break;
        }
        
        if (image) {
            [_itemImageCacheDict setObject:image forKey:@(itemType)];
        }
    }
    
    return image;
}

@end
