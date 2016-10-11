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
                if (itemType == CGWebViewItemTypeForward) {
                    config.canvasRotateAngle    = 90;
                }
                image   = [UIImage drawArrowWithConfig:config];
            }
                break;
            case CGWebViewItemTypeStopLoading:
            {
                image   = [UIImage drawCloseWithConfig:[CGCloseIconConfig new]];
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
