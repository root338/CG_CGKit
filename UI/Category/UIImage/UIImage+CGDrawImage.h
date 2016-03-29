//
//  UIImage+CGDrawImage.h
//  QuickAskCommunity
//
//  Created by DY on 16/3/28.
//  Copyright © 2016年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface UIImage (CGDrawImage)

- (UIImage *)cg_drawImageInRect:(CGRect)frame;

@end
NS_ASSUME_NONNULL_END