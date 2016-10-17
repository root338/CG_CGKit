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
#import "CGRefreshIconConfig.h"

#import "UIImage+CGDrawIcon.h"
#import "UIImage+CGImageRotate.h"
#import "UIEdgeInsets+Category.h"

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
                    config.arrowVertexOrientationType   = CGOrientationTypeRight;
                    config.marginEdgeInset              = UIEdgeInsetsZeroMakeExcludeLeft(8);
                }else {
                    config.arrowVertexOrientationType   = CGOrientationTypeLeft;
                    config.marginEdgeInset              = UIEdgeInsetsZeroMakeExcludeRight(8);
                }
                image   = [UIImage drawArrowWithConfig:config];
            }
                break;
            case CGWebViewItemTypeStopLoading:
            {
                CGCloseIconConfig *config   = [CGCloseIconConfig new];
                image   = [UIImage drawCloseWithConfig:config];
            }
                break;
            case CGWebViewItemTypeReload:
            {
                CGRefreshIconConfig *config = [CGRefreshIconConfig new];
                image   = [UIImage drawRefreshImageWithConfig:config];
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
