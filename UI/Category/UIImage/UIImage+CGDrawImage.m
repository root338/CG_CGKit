//
//  UIImage+CGDrawImage.m
//  QuickAskCommunity
//
//  Created by DY on 16/3/28.
//  Copyright © 2016年 ym. All rights reserved.
//

#import "UIImage+CGDrawImage.h"

@implementation UIImage (CGDrawImage)

- (UIImage *)cg_drawImageInRect:(CGRect)frame
{
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 1);
    
    [self drawInRect:frame];
    UIImage *drawImage  = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return drawImage;
}

//+ (UIImage *)cg_drawImageInRect:(CGRect)frame text:(nonnull NSAttributedString *)text viewContentModel:(NSTextAlignment)textAlignment
//{
//    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 1);
//    
//    
//}
@end
