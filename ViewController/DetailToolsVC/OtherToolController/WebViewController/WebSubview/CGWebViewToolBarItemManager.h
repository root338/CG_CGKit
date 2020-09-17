//
//  CGWebViewToolBarItemManager.h
//  TestCG_CGKit
//
//  Created by apple on 16/10/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGWebViewToolBarHeader.h"

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/** 网页视图item的管理 */
@interface CGWebViewToolBarItemManager : NSObject

- (nullable UIImage *)getImageWithItemType:(CGWebViewItemType)itemType;

@end

NS_ASSUME_NONNULL_END
